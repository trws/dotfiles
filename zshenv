source $ZDOTDIR/sysmagic

fpath=(
       $fpath
       /home/njustn/.zen/zsh/scripts
       /home/njustn/.zen/zsh/zle )
autoload -U zen

setopt nonomatch

for task in environment pathsetup; do
	for file in $ZDOTDIR/{,mine/}$task $ZDOTDIR/{,mine/}$task.${^zshuse}
		[[ -f $file ]] && source $file
	[[ -f $ZDOTDIR/mine/$i.override ]] && source $ZDOTDIR/$i.override
done

#export SSH_AUTH_SOCK=/tmp/502/SSHKeychain.socket

umask 022
[[ -f $ZDOTDIR/mine/umask ]] && umask $(<$ZDOTDIR/mine/umask);
#  [[ -f ~/.ssh/id_dsa ]] && ssh-add ~/.ssh/id_dsa >& /dev/null
#  new key adding code below, automatically adds any keys that do not exist in
#  the agent, could still end up with a long list this way, but all valid and no
#  duplicates
if [[ ! -r "$SSH_AUTH_SOCK" ]]
then
    for AGENT in `ls /tmp/ssh-*/agent*`
    do
        if [[ -r $AGENT ]]
        then
            export SSH_AUTH_SOCK=$AGENT
            break
        fi
    done
fi
if [[ -n "$SSH_AUTH_SOCK" ]]
then
    for X in `find ~/.ssh/ -name 'id_*' -not -name '*.pub' -exec grep -L ENCRYPTED {} +`
    do
        grep $(cat $X.pub | cut -d ' ' -f 2) <(ssh-add -L) >& /dev/null || ssh-add $X ;
    done
fi
typeset -U path cdpath fpath manpath
