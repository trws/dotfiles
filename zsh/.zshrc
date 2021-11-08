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
if [[ ${roothosts[(i)$HOST]} -le ${#roothosts} ]] ; then
  export gotroot=1
fi

fpath=($ZDOTDIR/funcs $fpath)
autoload -Uz $ZDOTDIR/funcs/*(.:t)

mkdirp_if_missing ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh
zstyle ':completion:*:default:' cache-path $ZSH_CACHE_DIR/zcompcache


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
    $TIC -xe $t terminfo.src
  done
}
function update_terminfo() {
  zinit ice extract cloneonly as"null" pick"" atclone"gunzip -f terminfo.src.gz ; import_terminfo tmux tmux-256color kitty kitty-direct iterm2 iterm2-direct alacritty-direct" atpull"%atclone"
  zinit snippet https://invisible-island.net/datafiles/current/terminfo.src.gz
}
# update_terminfo

if ! (( ${+commands[fzf]} )) ; then
  echo no fzf
  if ! (( ${+commands[go]} )) ; then
    echo go is missing, fix it to get fzf
  else
    typeset -a zimpaths
    zimpaths+=$ZIM_HOME/modules/fzf
    echo $zimpaths
  fi
fi
if (( ${+commands[fzf]} )) ; then
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

function brew_or_cargo() {
  zparseopts -D -E -F - -brew:=bpkg -cargo:=cpkg
  local cmd=$1
  if ! (( ${+commands[$cmd]} )) ; then
    if (( ${+commands[brew]} )) ; then
      brew install ${bpkg[1]}
    elif (( ${+commands[cargo]} )) ; then
      cargo install $pkg
    else
      echo brew and cargo are missing, fix it to get $cmd
    fi
  fi
}

brew_or_cargo --brew ripgrep --cargo ripgrep rg
brew_or_cargo --brew dust --cargo dust dust

# use asdf to ensure rust and go are available at acceptable versions
#export RUST_WITHOUT=rust-docs
#export ASDF_DIR=~/.cache/asdf
#export ASDF_DATA_DIR=~/.cache/asdf
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
#[[ -e ~/.envrc ]] || ln -s ~/.dotfiles/direnv/base-envrc ~/.envrc
#[[ -d ~/.config/direnv ]] || ln -s ~/.dotfiles/direnv/ ~/.config/direnv

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
# prompt powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

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
# -----------------
# Zim configuration
# -----------------
# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'
# --------------------
# Module configuration
# --------------------
#
# completion
#
# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"
#
# git
#
# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'
#
# input
#
# Append \`../\` to your input for each \`.\` you type after an initial \`..\`
#zstyle ':zim:input' double-dot-expand yes
#
# termtitle
#
# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'
#
# zsh-autosuggestions
#
# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
#
# zsh-syntax-highlighting
#
# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
# ------------------
# Initialize modules
# ------------------
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  command mkdir -p ${ZIM_HOME}
  if (( ${+commands[curl]} )); then
    command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if it does not exist
  # or it's outdated, before sourcing it.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh
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

# prompt powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

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

# make fzf actually load as a plugin
if [[ -d $ZIM_HOME/modules/fzf ]] ; then
  source $ZIM_HOME/modules/fzf/shell/completion.zsh
  source $ZIM_HOME/modules/fzf/shell/key-bindings.zsh
fi


if [[ $PROF_INIT == "true" ]] ; then
  zprof
fi

