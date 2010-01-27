#! /bin/bash

rsync --exclude ".svn/" --exclude "documentation/"  --delete -avz -e ssh  htdocs/ vim-latex-web:htdocs/
