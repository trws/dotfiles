#!/bin/sh
WEBDIR=~/.dotfiles/web-local

cd $WEBDIR
# /usr/local/bin/twistd -n -d $WEBDIR web -p 8080
python3 -m http.server 8080

