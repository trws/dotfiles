#!zsh
source ~/.todo/config
if [[ -f $TODO_DIR/todo.txt ]]
then
    command todo.sh ${@}
else
    command ssh hurricane todo.sh "${@}"
fi

