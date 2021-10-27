# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
  # echo Warning: no compiled zinit module
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

function zinit-setup() {
zinit ice sbin"fasd" pick"fasd" \
  src"fasd-init" \
  atclone"./fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| fasd-init" \
  atpull"%atclone" \
  lucid wait
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
  zinit ice extract cloneonly as"null" pick"" atclone"gunzip -f terminfo.src.gz ; import_terminfo tmux tmux-256color kitty kitty-direct iterm2 iterm2-direct alacritty-direct" atpull"%atclone"
  zinit snippet https://invisible-island.net/datafiles/current/terminfo.src.gz
}
update_terminfo

# prezto components
zinit snippet PZTM::helper
zinit snippet PZTM::environment
zinit snippet PZTM::terminal
zinit snippet PZTM::editor
zinit snippet PZTM::gnu-utility
zinit snippet PZTM::ssh
zinit snippet PZTM::history
zinit snippet PZTM::directory
zinit snippet PZTM::spectrum
zinit ice wait lucid
zinit snippet PZTM::utility

if [[ $SYSTEM = darwin ]] ; then
  zinit ice wait lucid
  zinit snippet PZTM::homebrew
  zinit snippet PZTM::osx
fi

zinit ice submod'external'
zinit snippet OMZP::tmux

# these require the whole directory rather than a file
zinit ice svn
zinit snippet PZTM::git

# vims, vim-stream to run a vim command on each line of a pipe, vim as sed
# basically
zinit null sbin"vims" for MilesCranmer/vim-stream


# issues with this version, trying something new
# zinit ice svn
# zinit snippet PZTM::syntax-highlighting
# amazing fzf git interactions
forgit_log=gl
forgit_diff=gd
forgit_add=ga
forgit_reset_head=gwrh
forgit_ignore=gi
forgit_checkout_file=gcf
forgit_checkout_branch=gcb
forgit_checkout_commit=gco
forgit_clean=gclean
forgit_stash_show=gss
forgit_cherry_pick=gcp
forgit_rebase=grb
forgit_fixup=gfu

zinit as"null" wait"3" lucid for \
  sbin Fakerr/git-recall \
  sbin paulirish/git-open \
  sbin paulirish/git-recent \
  sbin atload"export _MENU_THEME=legacy" \
  arzzen/git-quick-stats \
  sbin iwata/git-now \
  sbin"bin/git-dsf;bin/diff-so-fancy" zdharma/zsh-diff-so-fancy \
  sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" zdharma/git-url \

  zinit wait"1" lucid for wfxr/forgit


# sorin-ionescu/prezto path:modules/python
# copied to zsh/completions.zsh
# sorin-ionescu/prezto path:modules/completion

# completions
# zinit wait"1" lucid blockf atpull'zinit creinstall -q .' for \
#     zsh-users/zsh-completions

zinit ice submods'zsh-users/zsh-completions -> external' wait"1" lucid blockf atpull'zinit creinstall -q .'
zinit snippet PZTM::completion

function _spack_load() {
  source "${SPACK_ROOT}/share/spack/setup-env.sh"
}
zinit ice lucid wait'1' atinit'export SPACK_SKIP_MODULES=1' sbin'bin/spack' pick'share/spack/setup-env.sh >& /dev/null' atinit'export SPACK_ROOT=$(pwd)'
zinit load spack/spack

# function spack() {
#   if [[ -z "$SPACK_LOADED" ]] ; then
#     source "${SPACK_ROOT}/share/spack/setup-env.sh"
#   fi
#   spack "$@"
# }

zinit ice lucid wait sbin'direnv' make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit load direnv/direnv

zinit sbin"bin/(fzf|fzf-tmux)" \
  atclone"cp shell/completion.zsh _fzf_completion" \
  atpull"%atclone" \
  multisrc"shell/{key-bindings,completion}.zsh" \
  make"install" for junegunn/fzf

zinit light Aloxaf/fzf-tab
zinit light wookayin/fzf-fasd

zinit ice pip"pipx" sbin"p:venv/bin/pipx" id-as"pipx"
zinit load zdharma/null

# use asdf to ensure rust and go are available at acceptable versions
export RUST_WITHOUT=rust-docs
function asdf_plugins() {
  local plugins=(golang rust python )

  for p in $plugins ; do
    asdf plugin add $p
  done
  asdf install
}
zinit ice id-as'asdf' pick'asdf.sh' sbin'bin/asdf' atclone'asdf_plugins' atload'export ASDF_DATA_DIR=$(pwd)/data'
zinit load asdf-vm/asdf

if [[ ! ~/.tool-versions -ef ~/.dotfiles/asdf/tool-versions ]] ; then
  ln -sf ~/.dotfiles/asdf/tool-versions ~/.tool-versions
fi

zinit ice from"gh-r" as"program" mv"shfmt* -> shfmt"
zinit light mvdan/sh

function vivid_gen() {
  echo "export LS_COLORS=\"$(./vivid/vivid generate jellybeans)\"" > clrs.zsh
}

function vivid_load() {
  zinit ice atclone"vivid_gen" \
    atpull'%atclone' pick"clrs.zsh" \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
    lucid wait from'gh-r' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid'

  zinit load sharkdp/vivid
}
vivid_load

function load_tools() {
  if [[ ! $ARCH =~ ppc64 ]] ; then
    # binary stuff we can't have on ppc here
    # fd, bat, hyperfine, vivid
    for tool in fd bat hyperfine ; do
      if (( !$+commands[$tool] )) ; then
        zinit ice wait lucid from'gh-r' mv'$tool* $tool' sbin"**/$tool(.exe|) -> $tool"
        zinit load sharkdp/$tool
      fi
    done

    # ogham/exa, replacement for ls
    zinit ice lucid wait"2" lucid from"gh-r" sbin"bin/exa" mv"exa* -> exa"
    zinit load ogham/exa

    # dandavision/delta
    zinit ice lucid wait"2" from"gh-r" mv"delta* -> delta" sbin"delta/delta"
    zinit load dandavison/delta

    # gh cli
    zinit ice from"gh-r" sbin"**/bin/gh" atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone'
    zinit light cli/cli

    zinit ice lucid wait"2" from"gh-r" mv"dust* -> dust" sbin"dust/dust"
    zinit load bootandy/dust

    # BurntSushi/ripgrep
    zinit ice lucid wait"2" from"gh-r" mv"ripgrep* -> rg" sbin"rg/rg"
    zinit load BurntSushi/ripgrep

    # Installs rust and then the `lsd' crate and creates
    # the `lsd' shim exposing the binary
    # zinit ice id-as"cargo-apps" rustup cargo'!lsd'
    # zinit load zdharma/null

  else
    zinit ice cargo'vivid' id-as'vivid' sbin'bin/vivid'
    zinit load zdharma/null

    zinit ice cargo'ripgrep' id-as'rg' sbin'bin/rg'
    zinit load zdharma/null

    zinit ice cargo'fd-find' id-as'fd' sbin'bin/fd'
    zinit load zdharma/null

    zinit ice cargo'du-dust' id-as'dust' sbin'bin/dust'
    zinit load zdharma/null

  fi
}
load_tools

# Documented to be loaded last, delay longer
# Autosuggestions & fast-syntax-highlighting
zinit ice wait"1" lucid atinit"zpcompinit; zpcdreplay" atload"FAST_HIGHLIGHT[chroma-git]=\"chroma/-ogit.ch\""
zinit light zdharma/fast-syntax-highlighting
# zsh-autosuggestions
zinit ice wait"1" lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions
zinit ice wait"1.1" lucid
zinit load zsh-users/zsh-history-substring-search

}
if ! is-at-least 5.3 ; then
  echo You are running the horrifyingly ancient zsh version: $ZSH_VERSION
  echo running in a severely degraded mode
else
  zinit-setup
fi
# source antibody output
# source $_ab_path

# pl10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

function dbg_prompt_segment() {
  local cmd=("p10k" "segment")
  if [[ -n "${prompt_dbg+1}" ]] ; then
    cmd=echo
  fi
  $cmd "$@"
}
# custom prompt support functions
function prompt_flux_id() {
  dbg_prompt_segment -f green -c "$FLUX_URI" -i '' -t "$FLUX_URI"
}
function prompt_slurm_id() {
  dbg_prompt_segment -f red -c "$SLURM_JOB_ID" -i '' -t "$SLURM_JOB_ID"
}
function prompt_lsf_id() {
  dbg_prompt_segment -f blue -c "$LSB_JOBID" -i '' -t "$LSB_JOBID"
}
function prompt_zinit_mod() {
  local missing=''
  if [[ -f "$_zinit_mod_path/zdharma/zplugin.bundle" ]] ; then
  else
    missing='zmod'
  fi
  dbg_prompt_segment -f red -c "$missing" -i '!' -t "$missing"
}
function prompt_spack_env() {
  dbg_prompt_segment -f blue -c "$SPACK_ENV" -i '' -t "$SPACK_ENV:t"
}
# load my prompt, must be after async loads
autoload -Uz promptinit && promptinit
# prompt mypure
# prompt powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

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

