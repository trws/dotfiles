#! /bin/bash

rsync --exclude "documentation/"  --delete -avz -e ssh  htdocs/ vim-latex-web:htdocs/
