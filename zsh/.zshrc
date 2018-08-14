#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# use a decent version...
if [[ $ZSH_VERSION < "5.0.0" ]] ; then
    [[ -x ~/programs/chaos_5_x86_64_ib/bin/zsh ]] && exec ~/programs/chaos_5_x86_64_ib/bin/zsh
fi

ZSH_CACHE_DIR=~/.cache/zsh
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
fpath=($ZDOTDIR/funcs $fpath)
for func in ${^fpath}/*(N-.x:t); do
  autoload $func
done
compdef bmake=make
compdef bcmake=cmake
export gotroot=1

mkdir -p ~/.cache/zsh
export HISTFILE=~/.cache/zsh/zhistory

# use the builtin, seriously...
if typeset -f '[' > /dev/null ; then
    unset -f '['
fi

export _Z_NO_PROMPT_COMMAND=1
export _Z_DATA=$ZSH_CACHE_DIR/z-dirjump-list.txt
# export _Z_OWNER=$USER
. $ZDOTDIR/z.sh
function precmd () {
_z --add "$(pwd -P)"
}

if [ -f /usr/local/tools/dotkit/init.zsh ] ; then
    source /usr/local/tools/dotkit/init.zsh
elif [ -f /usr/local/tools/dotkit/init.sh ] ; then
  emulate sh -c 'source /usr/local/tools/dotkit/init.sh'

  #wrap the bloody thing, this is to support ancient zsh versions as on LC
  eval "orig_$(functions use)"
  eval "orig_$(functions unuse)"
  emulate sh -c '
  function use(){
    orig_use $@
  }
  function unuse(){
    orig_unuse $@
  }'
  use clang-omp-3.5.0
fi

if [ -x "$(which spack)" ] ; then
  SPACKDIR=$(dirname $(dirname $(which spack )))
  export MODULEPATH=${SPACKDIR}/share/spack/modules:${MODULEPATH}

  #TODO: takes WAY too long
  # source ${SPACKDIR}/share/spack/setup-env.sh

  # using links in programs dir
  # for PKG in git python tmux vim task taskd ruby tmuxinator the_silver_searcher; do
  #   spack use $PKG
  # done
else
#pull in dotkit with emulation for crappy shells
  if [ -f /usr/local/tools/dotkit/init.sh ] ; then
    myuse git
    myuse python
  fi
fi

#color setup for ls
if type dircolors > /dev/null ; then
  if [[ -f $ZDOTDIR/dir_colors ]] ; then
    eval $(dircolors -b $ZDOTDIR/dir_colors)
  elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
  fi
fi

for task in aliases; do
  for file in $ZDOTDIR/{,mine/}$task $ZDOTDIR/{,mine/}$task.${^zshuse} ; do
    [[ -f $file ]] && source $file
    [[ -f $ZDOTDIR/mine/$i.override ]] && source $ZDOTDIR/$i.override
  done
done

# completion
setopt ALWAYS_TO_END

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set up keybindings
for file in $ZDOTDIR/{,mine/}bindings $ZDOTDIR/{,mine/}bindings.$TERM \
  $ZDOTDIR/{,mine/}bindings.${TERM%%-*}
[[ -f $file  ]] && source $file

# make tmux behave with bracketed paste supporting terminals
if [ ${TMUX} ]; then
    unset zle_bracketed_paste
fi

if [[ -x fzf && -f ~/.fzf.zsh ]] ; then
    . ~/.fzf.zsh
fi
