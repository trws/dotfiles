# Executes commands at the start of an interactive session.
# Author: Tom Scogland

# use a decent version...
# TODO: make this more general
if [[ $ZSH_VERSION < "5.0.0" ]] ; then
  [[ -x ~/programs/chaos_5_x86_64_ib/bin/zsh ]] && exec ~/programs/chaos_5_x86_64_ib/bin/zsh
fi

mkdir -p ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh

# ensure my funcs, and prompts are there before load
fpath=($ZDOTDIR/funcs $fpath)

if ssh-add -l >& /dev/null ; then
  echo ${SSH_AUTH_SOCK} > ~/.cache/current-auth
else
  auth_sock="$(cat ~/.cache/current-auth)"
  if [[ -S $auth_sock ]] ; then
    export SSH_AUTH_SOCK=$auth_sock
    if ssh-add -l >& /dev/null ; then
    else
      echo warning: no auth
      unset SSH_AUTH_SOCK
    fi
  fi
fi

if infocmp xterm-256color-italic >& /dev/null ; then
else
  cat > /tmp/xterm-256-italic.terminfo <<EOF
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
EOF
  tic -x /tmp/xterm-256-italic.terminfo
fi


if infocmp tmux >& /dev/null ; then
else
  cat > /tmp/tmux.terminfo <<EOF
tmux|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color,
EOF
  tic -x /tmp/tmux.terminfo
fi

# prezto style settings
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'github_rsa'
zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern' \
  'line' \
  'root'

if (( ! $+commands[antibody] )) ; then
  if (( $+commands[brew] )) ; then
    brew install getantibody/tap/antibody
  elif (( $+commands[go] )) ; then
    go get -v github.com/getantibody/antibody
  else
    echo Install go or brew!
  fi
fi


_ab_dir=${HOME}/.cache/antibody
_ab_path=$_ab_dir/init.zsh

function zupdate() {
  mkdir -p $_ab_dir
  rm -f $_ab_path
  antibody bundle < $ZDOTDIR/antibody_bundles.txt > $_ab_path
}
if [[ ! -s $_ab_path ]]; then
  zupdate
fi

# source antibody output
source $_ab_path

# load my prompt, must be after async loads
autoload -Uz promptinit && promptinit
prompt mypure

source $ZDOTDIR/completions.zsh
compdef bmake=make
compdef bcmake=cmake

roothosts=(storm vortex deb hurricane gale wind)
if [[ ${roothosts[(i)$HOST]} -le ${#roothosts} ]] ; then
  export gotroot=1
fi

export HISTFILE=~/.cache/zsh/zhistory

# use the builtin, seriously...
if typeset -f '[' > /dev/null ; then
  unset -f '['
fi

# Turn off the stop key binding
stty -ixon

# this is a re-work of z from oh-my-zsh
export _Z_NO_PROMPT_COMMAND=1
export _Z_DATA=$ZSH_CACHE_DIR/z-dirjump-list.txt
# export _Z_OWNER=$USER
. $ZDOTDIR/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

if [ -x "$(which spack)" ] ; then
  SPACKDIR=$(dirname $(dirname $(which spack )))
  export MODULEPATH=${SPACKDIR}/share/spack/modules:${MODULEPATH}

  #TODO: takes WAY too long
  # source ${SPACKDIR}/share/spack/setup-env.sh

  # using links in programs dir
  # for PKG in git python tmux vim task taskd ruby tmuxinator the_silver_searcher; do
    #   spack use $PKG
    # done
fi

# pull in aliases
source $ZDOTDIR/aliases
# pull in backwards compatibility bindings for screen, etc.
  source $ZDOTDIR/bindings

# completion
setopt ALWAYS_TO_END


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# make tmux behave with bracketed paste supporting terminals
if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

if [[ -x fzf && -f ~/.fzf.zsh ]] ; then
  . ~/.fzf.zsh
fi
