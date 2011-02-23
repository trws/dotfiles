# reload term definition after TERMINFO set from env
TERM=$TERM;

#if [ "$SYSTEM" == "darwin" ]
#then
#  if ps -A | grep quartz-wm > /dev/null 
#  then
#    if [[ -n `ps -A | grep autocut | grep -v grep` ]]
#    then
#      echo autocut running nicely
#    else
#      autocutsel -fork
#      echo autocut started
#    fi
#  fi
#fi

#color setup for ls
if type dircolors > /dev/null ; then
  if [[ -f ~/.dir_colors ]] ; then
    eval $(dircolors -b ~/.dir_colors)
  elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
  fi
fi

#echo $terminfo > ~/test1
for task in aliases promptstuff; do
  for file in $ZDOTDIR/{,mine/}$task $ZDOTDIR/{,mine/}$task.${^zshuse}
  [[ -f $file ]] && source $file
  [[ -f $ZDOTDIR/mine/$i.override ]] && source $ZDOTDIR/$i.override
done

# Load functions
fpath=($ZDOTDIR/mine/funcs $ZDOTDIR/funcs $fpath)
[[ -d $ZDOTDIR/funcs.$system ]] && fpath=($fpath $ZDOTDIR/funcs.$system)
for func in ${^fpath}/*(N-.x:t); autoload $func

  # Hosts to use for completion
  # thanks repose.cx/conf/.zshrc for the ssh/known_hosts trick
  ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
  hosts=( $hosts $ssh_hosts $(<$ZDOTDIR/hosts))
  typeset -U hosts ssh_hosts

  # Misc variables
  MAILCHECK=300 HISTSIZE=200 DIRSTACKSIZE=20

  # Watch for my friends
  [[ -f $ZDOTDIR/mine/friends ]] && watch=($(<$ZDOTDIR/mine/friends) $watch)
  for j in $zshuse; do
    [[ -f $ZDOTDIR/mine/friends.$i ]] && 
    watch=($(<$ZDOTDIR/mine/friends.$i) $watch )
  done
  LOGCHECK=300 WATCHFMT='%n %a %l from %m at %t.'

  # Set/unset shell options
  source $ZDOTDIR/options

  # Autoload zsh modules when they are referenced
  zmodload -a zsh/stat stat
  zmodload -a zsh/zpty zpty
  zmodload -a zsh/zprof zprof
  zmodload -a zsh/complist complist
  zmodload -ap zsh/mapfile mapfile

  # Set up completion
  # TODO zcomprc should probably be conditional
  if [[ -f $ZDOTDIR/styles ]] { . $ZDOTDIR/styles }
  autoload -U compinit
  compinit -d ~/.zcompdump
  compinit $(! (($UID)) && print -- "-i" "-d" ~/.zcompdump.root)

  # Clean up arrays
  typeset -U path cdpath fpath manpath

  # Set up keybindings
  for file in $ZDOTDIR/{,mine/}bindings $ZDOTDIR/{,mine/}bindings.$TERM \
    $ZDOTDIR/{,mine/}bindings.${TERM%%-*}
    [[ -f $file  ]] && source $file

    true


    [[ -n "$terminfo[kbs]" ]] && stty erase $terminfo[kbs]

#echo $terminfo > ~/test2
    # vim:ts=4:
