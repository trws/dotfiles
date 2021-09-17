# Executes commands at the start of an interactive session.
# Author: Tom Scogland
# PROF_INIT=false
if [[ $PROF_INIT == "true" ]] ; then
  zmodload zsh/zprof
fi

declare -A ZINIT
ZINIT[HOME_DIR]=~/.cache/zsh/zinit
if [[ $ARCH != x86_64 ]] ; then
  ZINIT[HOME_DIR]=~/.cache/zsh/zinit/$ARCH/
fi
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"
if [[ ! -f "${ZINIT[BIN_DIR]}/zinit.zsh" ]] ; then
  mkdir -p "${ZINIT[HOME_DIR]}"
  git clone https://github.com/zdharma/zinit "${ZINIT[BIN_DIR]}"
fi

_zinit_mod_path="${ZINIT[BIN_DIR]}/zmodules/Src"
if [[ -f "$_zinit_mod_path/zdharma/zplugin.bundle" ]] ; then
  module_path+=( "$_zinit_mod_path" )
  zmodload zdharma/zplugin
else
  echo Warning: no compiled zinit module 
fi

# use a decent version...
# TODO: make this more general
if [[ $ZSH_VERSION < "5.0.0" ]] ; then
  [[ -x ~/programs/chaos_5_x86_64_ib/bin/zsh ]] && exec ~/programs/chaos_5_x86_64_ib/bin/zsh
fi

fpath=($ZDOTDIR/funcs $fpath)
autoload -Uz $ZDOTDIR/funcs/*(.:t)

mkdirp_if_missing ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh
zstyle ':completion:*:default:' cache-path $ZSH_CACHE_DIR/zcompcache


# prezto style settings
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
zstyle ':prezto:module:ssh:load' identities

source $ZDOTDIR/completions.zsh
compdef bmake=make
compdef bcmake=cmake


# Bring in zinit
source "${ZINIT[BIN_DIR]}/zinit.zsh"

# zinit sources and plugins
zinit load zinit-zsh/z-a-meta-plugins
# pulling in z-a-bin-gem-node, rust and submods
zinit for annexes

# general plugins
zinit load mafredri/zsh-async
zinit ice wait lucid for 
zinit load Tarrasch/zsh-autoenv

# command/script
export _FASD_DATA=$ZSH_CACHE_DIR/z-dirjump-list.txt
export ZSHZ_DATA=${_FASD_DATA}
zinit ice sbin"fasd" pick"fasd" \
  src"fasd-init" \
  atclone"./fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| fasd-init" \
  atpull"%atclone"
zinit load clvv/fasd

# terminfo updates, no more missing terminfo YAY!
function import_terminfo() {
  local TIC=tic
  local INFOCMP=infocmp
  if [[ $SYSTEM == darwin ]] ; then
    # must use system, and not homebrew, versions on mac
    TIC=/usr/bin/tic
    INFOCMP=/usr/bin/infocmp
  fi
  local t
  for t in "$@" ; do
    $TIC -xe $t terminfo.src
  done
}
function update_terminfo() {
  zinit ice extract as"command" pick"" atclone"gunzip terminfo.src.gz ; import_terminfo tmux tmux-256color kitty kitty-direct iterm2 iterm2-direct alacritty-direct" atpull"%atclone"
  zinit snippet https://invisible-island.net/datafiles/current/terminfo.src.gz
}
update_terminfo

# prezto components
zinit snippet PZTM::helper
zinit snippet PZTM::environment
zinit snippet PZTM::terminal
zinit snippet PZTM::editor
zinit snippet PZTM::gnu-utility
zinit ice wait lucid
zinit snippet PZTM::homebrew
zinit snippet PZTM::osx
zinit snippet PZTM::ssh
zinit snippet PZTM::history
zinit snippet PZTM::directory
zinit snippet PZTM::spectrum
zinit ice wait lucid
zinit snippet PZTM::utility
# zinit snippet PZTM::history-substring-search
zinit ice wait lucid
zinit load zsh-users/zsh-history-substring-search

zinit snippet OMZP::tmux

zinit ice submod'external'
zinit snippet OMZP::tmux

# these require the whole directory rather than a file
zinit ice svn
zinit snippet PZTM::git


# issues with this version, trying something new
# zinit ice svn
# zinit snippet PZTM::syntax-highlighting
zinit ice wait lucid
zinit load wfxr/forgit
# sorin-ionescu/prezto path:modules/python
# copied to zsh/completions.zsh
# sorin-ionescu/prezto path:modules/completion

# completions
# zinit wait"1" lucid blockf atpull'zinit creinstall -q .' for \
#     zsh-users/zsh-completions

zinit ice submods'zsh-users/zsh-completions -> external' wait"1" lucid blockf atpull'zinit creinstall -q .'
zinit snippet PZTM::completion


if (( ! $+commands[direnv] )) ; then
  zinit ice has"go" as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
  zinit load direnv/direnv
fi

zinit ice sbin"bin/(fzf|fzf-tmux)" \
    atclone"cp shell/completion.zsh _fzf_completion" \
    atpull"%atclone" \
    pick"shell/key-bindings.zsh" \
    make"install"
zinit load junegunn/fzf

zinit ice pip"pipx" fbin"p:venv/bin/pipx" id-as"pipx" fbin
zinit load zdharma/null


if [[ ! $ARCH =~ ppc64 ]] ; then
  # binary stuff we can't have on ppc here
  # sharkdp/fd
  zinit ice from"gh-r" mv"fd* -> fd" sbin"fd/fd"
  zinit load sharkdp/fd

  # sharkdp/bat
  zinit ice from"gh-r" mv"bat* -> bat" sbin"bat/bat"
  zinit load sharkdp/bat

  # ogham/exa, replacement for ls
  zinit ice wait"2" lucid from"gh-r" sbin"bin/exa" mv"exa* -> exa"
  zinit load ogham/exa

  # dandavision/delta
  zinit ice from"gh-r" mv"delta* -> delta" sbin"delta/delta"
  zinit load dandavison/delta

  # BurntSushi/ripgrep
  zinit ice from"gh-r" mv"ripgrep* -> rg" sbin"rg/rg"
  zinit load BurntSushi/ripgrep

  # Installs rust and then the `lsd' crate and creates
  # the `lsd' shim exposing the binary
  # zinit ice id-as"cargo-apps" rustup cargo'!lsd'
  # zinit load zdharma/null
else
fi

# Documented to be loaded last, delay longer
# Autosuggestions & fast-syntax-highlighting
zinit ice wait"1" lucid atinit"zpcompinit; zpcdreplay" atload"FAST_HIGHLIGHT[chroma-git]=\"chroma/-ogit.ch\""
zinit light zdharma/fast-syntax-highlighting
# zsh-autosuggestions
zinit ice wait"1" lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# source antibody output
# source $_ab_path

# load my prompt, must be after async loads
autoload -Uz promptinit && promptinit
prompt mypure

if infocmp $TERM >& /dev/null ; then
else
  echo $TERM: terminfo unavailable, falling back to xterm-256color
  export TERM=xterm-256color
fi



roothosts=(storm vortex deb hurricane gale wind chimera bolt falcon)
if [[ ${roothosts[(i)$HOST]} -le ${#roothosts} ]] ; then
  export gotroot=1
fi

HISTFILE=~/.cache/zsh/zhistory
# HISTFILE=~/.zsh-history-${HOST//[0-9]/}
HISTSIZE=10000
SAVEHIST=10000                # Default: 200
setopt INC_APPEND_HISTORY
setopt   APPEND_HISTORY        # multiple zsh's all append to same history file (rather than last
# setopt   SHARE_HISTORY        # share between instances
# overwrites)  SET
setopt HIST_FCNTL_LOCK #use file locking to allow multiple writers to collaborate on a history file, important for clusters with NFS
setopt banghist             # Perform textual history expansion, csh-style, treating '!' specially  SET
unsetopt cshjunkiehistory     # A history reference without an event specifier will always refer to
# the previous command. Without this option, such a history reference
# refers to the same event as the previous history reference, defaulting
# to the previous command  UNSET
unsetopt   extendedhistory      # Save each command's beginning timestamp and the duration (in seconds)
# to the history file  UNSET
unsetopt histallowclobber     # Add '|' to output redirections in the history. This allows history
# references to clobber files even when CLOBBER is unset  UNSET
unsetopt histbeep             # Beep when attempt to access a history entry which isn't there  SET
setopt   histexpiredupsfirst  # If the internal history needs to be trimmed to add the current command
# line, setting this option will cause the oldest history event that has
# a duplicate to be lost before losing a unique event from the list  UNSET
unsetopt histfindnodups       # When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous  UNSET
setopt histignorealldups    # If a new command line being added to the history list duplicates an
# older one, the older command is removed from the list (even if it is
# not the previous event)  UNSET
unsetopt   histignoredups       # Do not enter command lines into the history list if they are
# duplicates of the previous event  UNSET
unsetopt histignorespace      # Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space  UNSET
unsetopt histnofunctions      # Remove function definitions from the history list  UNSET
unsetopt histnostore          # Remove the history (fc -l) command from the history list when invoked  UNSET
setopt   histreduceblanks     # Remove superfluous blanks from each command line being added to the
# history list  UNSET
setopt histsavenodups       # When writing out the history file, older commands that duplicate newer
# ones are omitted  UNSET
setopt   histverify           # Don't execute a line with history expansion directly; reload the line
# into the editing buffer  UNSET
setopt   incappendhistory     # New history lines are added to the $HISTFILE incrementally (as soon as
# they are entered), rather than waiting until the shell is killed  UNSET
unsetopt   sharehistory         # Import new commands from the history file and append typed commands to
# the history file  UNSET

# use the builtin, seriously...
if typeset -f '[' > /dev/null ; then
  unset -f '['
fi

# Turn off the stop key binding
stty -ixon


if [ -x "$(which spack)" ] ; then
  SPACKDIR=$(dirname $(dirname $(which spack )))
  # export MODULEPATH=${MODULEPATH}:${SPACKDIR}/share/spack/modules

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

# something is messing with pathsetup between zshenv and here
source $ZDOTDIR/sysmagic
source $ZDOTDIR/pathsetup

if [[ $PROF_INIT == "true" ]] ; then
  zprof
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
