# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ $HOST  == 'typhoon' ]] ; then
  SEGMENT_SEPARATOR='⮀'
  SEGMENT_REVERSE='⮂'
else
  SEGMENT_SEPARATOR='▶'
  SEGMENT_REVERSE='◀'
fi

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} " && COUNT=$(($COUNT + 2))
  else
    echo -n "%{$bg%}%{$fg%} " && COUNT=$(($COUNT + 1))
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ $CURRENT_BG != 'NONE' ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR" && COUNT=$(($COUNT + 1))
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
    local toexp="$user@%m"
    local context=${(%)toexp}
    COUNT=$(($COUNT + ${#context}))
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi
    echo -n "${ref/refs\/heads\//⭠ }$dirty"
  else
    local sinfo_complete sinfo_status
    sinfo_complete=$(svn info 2>&1)
    sinfo_status=$?
    if [ $sinfo_status -eq 0 ]; then
      local sinfo="$(svn info 2>/dev/null | grep 'Repository Root' | cut -f 3)"
      local origin="$(svn_repo_root_name $sinfo_complete)"
      # if [[ "$sinfo" =~ '.*charon.*' ]] ; then
      #   origin='Charon/'
      # elif [[ "$sinfo" =~ '.*(hurricane|scogland.com).*' ]] ; then
      #   origin='Hurricane/'
      # else
      #   origin="$(echo $sinfo | sed -e 's|.*[^:]*://[/]*\([^/]*\)/.*|\1|')/"
      #   #regexp-replace origin '://[/]*([^/]*)/' '$MATCH'
      # fi
      # dirty=$(svn status | grep -e '^M' -e '^C')
      # if [[ -n $dirty ]]; then
      #   prompt_segment yellow black
      # else
        prompt_segment green black
      # fi
      echo -n "svn:${origin}"
      # echo -n "svn:${origin}$(basename ${sinfo})"
    else
      local need_upgrade="$(svn_repo_need_upgrade $sinfo_complete 2>&1)"
      if [[ -n $need_upgrade ]] ; then
        prompt_segment red black
        echo -n "svn:upgrade!"
      else
        prompt_segment green black
      fi
    fi

  fi
}

# Dir: current working directory
prompt_dir() {
  local extra_sep=''
  #if [[ $CURRENT_BG == 'NONE' ]] ; then
    extra_sep="$SEGMENT_REVERSE"
  #fi
  #echo -n "%{%F{024}%}$CURRENT_BG$extra_sep%{%K{024}%}%{%F{254}%}%~ "
  echo -n "%{%F{024}%}$extra_sep%{%K{024}%}%{%F{254}%}%~ "
  #prompt_segment 024 254 "$extra_sep%~"
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘($RETVAL)" && COUNT=$(($COUNT + 3 + ${#RETVAL}))
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡" && COUNT=$(($COUNT + 1))
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙" && COUNT=$(($COUNT + 1))

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  COUNT=0
  prompt_context
  local cont_length=$COUNT
  local TIME="%D{%H:%M}"
  local DATE="%D{%a,%b%d,%y}"
  prompt_segment cyan black "$TIME"

  #echo -n "%K{cyan}%F{black}"
  #echo -n " %D{%H:%M}"
  #CURRENT_BG="cyan"
  prompt_status
  if [[ $CURRENT_BG != 'NONE' ]]; then
    echo -n " %{%{%K{235}%}%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR" && COUNT=$(($COUNT + 1))
  else
    echo -n "%{%k%}"
  fi
  CURRENT_BG="%{%K{235}%}"
  echo -n $CURRENT_BG

  #local pwdsize=${#${(%):-%~  %D{%H:%M}}}
  local pwdsize=${#${(%):-${TIME}${SEGMENT_SEPARATOR}${SEGMENT_REVERSE}${DATE}}}
  if [[  $cont_length -ne 0 ]] ; then
    pwdsize=$(($pwdsize + 2))
  else
    pwdsize=$(($pwdsize + 1))
  fi
  local nil=''
  PR_FILLBAR="\${(mr.(($COLUMNS - $pwdsize - $COUNT)).. .)nil}"
  echo -n "${(e)PR_FILLBAR}"
  echo -n "%K{black}%F{cyan}$SEGMENT_REVERSE%K{cyan}%F{black}"
  echo -n "$DATE"
  #echo $COUNT
  #echo -n "$COLUMNS $promptsize $pwdsize" (($COLUMNS - $pwdsize $COUNT))
  echo
  CURRENT_BG='NONE'
  prompt_git
  prompt_end
}
build_right(){
  prompt_dir
}

PROMPT='%{%f%b%k%}$(build_prompt) '

RPROMPT='$(build_right)'
