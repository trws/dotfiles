#
# Example .zlogin file for zsh 4.0
#
# .zlogin is sourced in login shells.  It should
# contain commands that should be executed only in
# login shells.  It should be used to set the terminal
# type and run a series of external commands (fortune,
# msgs, from, etc).
#

stty dec cr0 tabs
ttyctl -f
#mesg y
uptime
log
from 2>/dev/null
calendar 2>/dev/null || [[ -f ~/notes ]] && cat ~/notes
#msgs -fp
set -7
