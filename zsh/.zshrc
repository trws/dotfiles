# Executes commands at the start of an interactive session.
# Author: Tom Scogland

# use a decent version...
# TODO: make this more general
if [[ $ZSH_VERSION < "5.0.0" ]] ; then
  [[ -x ~/programs/chaos_5_x86_64_ib/bin/zsh ]] && exec ~/programs/chaos_5_x86_64_ib/bin/zsh
fi

mkdir -p ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh

fpath=($ZDOTDIR/funcs $fpath)

#prezto is annoying, avoid the brokenness
old_zdotdir=$ZDOTDIR
unset ZDOTDIR
ZGEN_AUTOLOAD_COMPINIT=0

zgen () {
  if [[ ! -s ${HOME}/.zgen/zgen.zsh ]]; then
    git clone --recursive https://github.com/tarjoilija/zgen.git ${HOME}/.zgen
  fi
  source ${HOME}/.zgen/zgen.zsh
  zgen "$@"
}

# if the init scipt doesn't exist
if [[ -s ${HOME}/.zgen/init.zsh ]]; then
  source ${HOME}/.zgen/init.zsh
else
  # specify plugins here
  zgen prezto editor key-bindings 'emacs'
  zgen prezto prompt theme 'mypure'
  zgen prezto syntax-highlighting highlighters  \
    'main' \
    'brackets' \
    'pattern' \
    'line' \
    'root'

  zgen prezto syntax-highlighting styles \
    'builtin' 'bg=blue' \
    'command' 'bg=blue' \
    'function' 'bg=blue'

  zgen prezto '*:*' color 'yes'
  zgen prezto 'git:status:ignore' submodules 'all'
  zgen prezto 'ssh:load' identities 'id_rsa' 'github_rsa'

  zgen prezto

  zgen prezto autosuggestions
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto git
  zgen prezto gnu-utility
  zgen prezto homebrew
  zgen prezto osx
  zgen prezto python
  zgen prezto rsync
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  zgen prezto tmux
  zgen prezto history
  zgen prezto directory
  zgen prezto spectrum
  zgen prezto utility
  zgen prezto completion
  zgen prezto prompt
  zgen prezto docker
  zgen load mafredri/zsh-async
  # zgen load maximbaz/spaceship-prompt


  # generate the init script from plugins above
  zgen save
fi
export ZDOTDIR=$old_zdotdir


# for func in ${^fpath}/*(N-.x:t); do
#   autoload $func
# done

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
COMPDUMP_PATH=$ZSH_CACHE_DIR/compdump-$SYS_TYPE
autoload -U compinit
# always run bashcompinit, it's fast anyway
autoload -U bashcompinit && bashcompinit

function recomp () {
  rm -f $COMPDUMP_PATH
  compinit -d $COMPDUMP_PATH
}

# only update compdump if it's been a day
if [[ -n $COMPDUMP_PATH(#qN.mh+24) ]]; then
  echo redoing
  compinit -d $COMPDUMP_PATH
else
  echo skipping
  compinit -d $COMPDUMP_PATH -C
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# make tmux behave with bracketed paste supporting terminals
if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

if [[ -x fzf && -f ~/.fzf.zsh ]] ; then
  . ~/.fzf.zsh
fi
