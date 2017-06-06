#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

for task in environment pathsetup; do
	for file in $ZDOTDIR/{,mine/}$task $ZDOTDIR/{,mine/}$task.${^zshuse}
		[[ -f $file ]] && source $file
	[[ -f $ZDOTDIR/mine/$i.override ]] && source $ZDOTDIR/$i.override
done

# if [[ ! -r "$SSH_AUTH_SOCK" ]] ; then
#     for AGENT in `ls /tmp/ssh-*/agent* 2> /dev/null`; do
#         if [[ -r $AGENT ]] ; then
#             export SSH_AUTH_SOCK=$AGENT
#             break
#         fi
#     done
# fi
