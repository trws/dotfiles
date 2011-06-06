#!zsh
if [[ -f ~/Dropbox/simplenote/todo.txt ]]
then
    command todo.sh ${@}
else
    command ssh hurricane todo.sh "${@}"
fi

