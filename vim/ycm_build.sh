#!/bin/bash

LOG=~/.cache/dein/ycm_build.log

git submodule update --init --recursive 2>&1 > $LOG

declare -a COMPLETERS
COMPLETERS+=' --clang-completer'
# [ -x $(which mono) ] && COMPLETERS+=' --omnisharp-completer'
# [ -x $(which rustc) ] && COMPLETERS+=' --racer-completer'
# [ -x $(which go) ] && COMPLETERS+=' --gocode-completer'
# [ -x $(which npm) ] && COMPLETERS+=' --tern-completer'

echo ./install.py $COMPLETERS
./install.py $COMPLETERS

