# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Executes commands at the start of an interactive session.
# Author: Tom Scogland
# PROF_INIT=false
if [[ $PROF_INIT == "true" ]] ; then
  zmodload zsh/zprof
fi

roothosts=(storm vortex deb hurricane gale wind chimera bolt falcon)
if [[ ${roothosts[(i)${HOST:=$(hostname)}]} -le ${#roothosts} ]] ; then
  export gotroot=1
fi

fpath=($ZDOTDIR/funcs $fpath)
autoload -Uz $ZDOTDIR/funcs/*(.:t)

mkdirp_if_missing ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh
zstyle ':completion:*:default:' cache-path $ZSH_CACHE_DIR/zcompcache
[ ! -d $ZSH_CACHE_DIR/zcompcache ] && mkdir -p $ZSH_CACHE_DIR/zcompcache


# FASD setup
export _FASD_DATA=$ZSH_CACHE_DIR/z-dirjump-list.txt
export ZSHZ_DATA=${_FASD_DATA}

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
    $TIC -xe $t ~/Downloads/terminfo.src
  done
}
function mydownload() {
  if (( ${+commands[curl]} )); then
    command curl -fsSL -o "${DDIR:-$HOME/Downloads}/${FN:-$(basename $1)}" "$1"
  else
    command wget -nv -O "${DDIR:-$HOME/Downloads}/${FN:-$(basename $1)}" "$1"
  fi
}
function update_terminfo() {
  mydownload https://invisible-island.net/datafiles/current/terminfo.src.gz
  gunzip -f ~/Downloads/terminfo.src.gz
  import_terminfo tmux tmux-256color kitty kitty-direct iterm2 iterm2-direct alacritty-direct atpull
}
# update_terminfo

# load dircolors
source ~/.dotfiles/zsh/dir_colors_vivid_jelly
zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”

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
function prompt_spack_env() {
  dbg_prompt_segment -f blue -c "$SPACK_ENV" -i '' -t "$SPACK_ENV:t"
}
# load my prompt, must be after async loads
autoload -Uz promptinit && promptinit
# prompt mypure

if infocmp $TERM >& /dev/null ; then
else
  echo $TERM: terminfo unavailable, falling back to xterm-256color
  export TERM=xterm-256color
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#
# -----------------
# Zsh configuration
# -----------------
#
# History
#
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS
#
# Input/output
#
# Set editor default keymap to emacs (\`-e\`) or vi (\`-v\`)
bindkey -e
# Prompt for spelling correction of commands.
#setopt CORRECT
# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'github_rsa'

# ensure we get homebrew completion
if (( $+commands[brew] )) ; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# clone antidote if necessary
[[ -e ~/.cache/antidote ]] || git clone https://github.com/mattmc3/antidote ~/.cache/antidote

autoload -U fasd
export ANTIDOTE_HOME=~/.cache/antidote
# source antidote
. ~/.cache/antidote/antidote.zsh
export _ab_dir=${XDG_CACHE_HOME:=~/.cache}/antidote
export _ab_path=$_ab_dir/init.zsh

function zupdate() {
  set -x
  [[ -d $_ab_dir ]] || mkdir -p $_ab_dir
  ( cat  | antidote bundle >! $_ab_path; ) <<EOF
# autoenv support, for .autoenv.zsh files
Tarrasch/zsh-autoenv

junegunn/fzf path:shell
junegunn/fzf path:shell/key-bindings.zsh
wookayin/fzf-fasd


# get gnu-utility support from prezto
$HOME/.dotfiles/zsh/gnu-utility

# zmodule asdf-vm/asdf --name asdf-vm -s asdf.sh
# zmodule asdf

# directory and file frecency
zimfw/fasd kind:fpath path:functions
zimfw/fasd

zimfw/exa

wfxr/forgit

sorin-ionescu/prezto
sorin-ionescu/prezto path:modules/git
sorin-ionescu/prezto path:modules/homebrew
# Enables and configures smart and extensive tab completion.
# completion must be sourced after zsh-users/zsh-completions
zsh-users/zsh-completions
sorin-ionescu/prezto path:modules/completion


# fzf for completion - buggy
# zmodule Aloxaf/fzf-tab

# -------
# Modules
# -------
# Sets sane Zsh built-in environment options.
zimfw/environment
# Provides handy git aliases and functions.
# zimfw/git # prezto-like
# Applies correct bindkeys for input events.
#more general handling for EOL and delete etc. than I had
zimfw/input
# Sets a custom terminal title.
zimfw/termtitle
# Utility aliases and functions. Adds colour to ls, grep and less.
zimfw/utility


#
# Prompt
#
romkatv/powerlevel10k
# Exposes to prompts how long the last command took to execute, used by asciiship.
zimfw/duration-info
# Exposes git repository status information to prompts, used by asciiship.
zimfw/git-info kind:fpath path:functions
# A heavily reduced, ASCII-only version of the Spaceship and Starship prompts.
zimfw/asciiship

# Fish-like autosuggestions for Zsh.
zsh-users/zsh-autosuggestions
# Fish-like syntax highlighting for Zsh.
# zsh-users/zsh-syntax-highlighting must be sourced after completion
zsh-users/zsh-syntax-highlighting
# Fish-like history search (up arrow) for Zsh.
# zsh-users/zsh-history-substring-search must be sourced after zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search

# Tmux
tmux-plugins/tpm kind:clone
EOF
  update_terminfo
}


# generate and source plugins from ~/.zsh_plugins.txt
if [[ ! -f $_ab_path ]] || [[ ! $_ab_path -nt $ZDOTDIR/.zshrc ]]; then
  zupdate
fi
source $_ab_path


# ------------------------------
# Post-init module configuration
# ------------------------------
#
# zsh-history-substring-search
#
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

if (( $+commands[asdf] )) ; then
  for plg in rust golang direnv neovim ; do
    [[ -d ${ASDF_DATA_DIR}/plugins/$plg ]] || asdf plugin add $plg
  done
fi

# use asdf to ensure rust and go are available at acceptable versions
#export RUST_WITHOUT=rust-docs
#
#function asdf_plugins() {
#  local plugins=(golang) # golang rust python)
#  # if ! asdf plugin list | grep direnv >& /dev/null ; then
#  #   asdf plugin-add direnv
#  # fi
#  # asdf install direnv latest
#  # asdf global direnv latest
#
#  for p in $plugins ; do
#    asdf plugin add $p
#    asdf install $p latest
#    asdf global $p latest
#  done
#}
#if [[ ! -f ~/.tool-versions ]] ; then
#  # ln -sf ~/.dotfiles/asdf/tool-versions ~/.tool-versions
#  asdf_plugins
#fi
[[ -e ~/.envrc ]] || ln -s ~/.dotfiles/direnv/base-envrc ~/.envrc
[[ -d ~/.config/direnv ]] || ln -s ~/.dotfiles/direnv/ ~/.config/direnv

function brew_or_cargo() {
  zparseopts -D -E -F - -brew:=bpkg -cargo:=cpkg
  local cmd=$1
  if (( ${+commands[$cmd]} )) ; then
    return
  fi
  if (( ${+commands[brew]} )) ; then
    if [[ -v INSTALL_TOOLS ]] ; then
      echo could install $cmd, set INSTALL_TOOLS to install
    else
      brew install ${bpkg[2]}
    fi
  elif (( ${+commands[cargo]} )) ; then
    if [[ -v INSTALL_TOOLS ]] ; then
      echo could install $cmd, set INSTALL_TOOLS to install
    else
      cargo install --root "$CARGO_HOME" ${cpkg[2]}
    fi
  else
    echo brew and cargo are missing, fix it to get $cmd
  fi
}


autoload is-at-least
if is-at-least 5.1; then
  if (( ${+commands[rustup]} )) ; then
    [[ -f ~/.rustup/settings.toml ]] || rustup default stable
  fi
  typeset -A mytools
  mytools[rg]='--brew ripgrep --cargo ripgrep'
  mytools[dust]='--brew dust --cargo du-dust'
  mytools[bat]='--brew bat --cargo bat'
  # mytools[delta]='--brew delta --cargo git-delta'
  mytools[hyperfine]='--brew hyperfine --cargo hyperfine'
  mytools[exa]='--brew exa --cargo exa'

  for cmd args in ${(kv)mytools} ; do
    brew_or_cargo ${=args} $cmd
  done

  if ! (( ${+commands[fd]} )) ; then
    if (( ${+commands[fdfind]} )) ; then
      alias fd=fdfind
    elif (( ${+commands[fd-find]} )) ; then
      alias fd=fd-find
    else
      brew_or_cargo --brew fd --cargo fd-find fd
    fi
  fi
fi

if ! (( ${+commands[fzf]} )) ; then
  go get -u github.com/junegunn/fzf
fi

if ! (( ${+commands[fzf]} )) ; then
  echo no fzf
  if ! (( ${+commands[go]} )) ; then
    echo go is missing, fix it to get fzf
  fi
else
  # forgit: amazing fzf git interactions forgit_log=gl forgit_diff=gd
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
fi

# not quite working, revisit
# if ! is-at-least 2.2.0 $(gh --version | awk -e '/ [0-9]+\.[0-9]+\.[0-9]+ /{ print $3}') ; then
#   echo installing updated gh
#   go get github.com/cli/cli/cmd/gh
# fi



# prompt powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
if is-at-least 5.1; then
  [[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
fi

# defaults to asciiship

HISTFILE=~/.cache/zsh/zhistory
# HISTFILE=~/.zsh-history-${HOST//[0-9]/}
HISTSIZE=10000
SAVEHIST=10000                # Default: 200
setopt INC_APPEND_HISTORY
setopt   APPEND_HISTORY        # multiple zsh's all append to same history file (rather than last
# setopt   SHARE_HISTORY        # share between instances
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

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

if [[ $PROF_INIT == "true" ]] ; then
  zprof
fi

