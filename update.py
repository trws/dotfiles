#!/usr/bin/python

import subprocess
import sys
import os
import string
import argparse

parser = argparse.ArgumentParser(description='Update and prepare dotfiles distribution')
parser.add_argument('-f', '--force', action='store_true', help='Replace existing links, will *NOT* delete files or directories, and *WILL* error out if you ask it to')
args = parser.parse_args()

script_path =  os.path.abspath(__file__)
script_dir =  os.path.dirname(script_path)

os.chdir(script_dir)

# subprocess.call(['git', 'pull'], stdout=sys.stdout, stderr=sys.stderr)
# subprocess.call(['git', 'submodule', 'update', '--init', '--recursive'], stdout=sys.stdout, stderr=sys.stderr)

link_files = {
        "vim" : "~/.vim",
        "vim/vimrc" : "~/.vimrc",
        "zsh" : "~/.zsh",
        "zsh/zshenv-link" : "~/.zshenv",
        "mjolnir" : "~/.mjolnir",
        "tmux.conf" : "~/.tmux.conf",
        "inspiration/mathias/.wgetrc" : "~/.wgetrc",
        "inspiration/mathias/.curlrc" : "~/.curlrc",
        "gitignore" : "~/.gitignore",
        "gitconfig" : "~/.gitconfig",
        }

for target, link in link_files.items():
    l_path = os.path.expanduser(link)
    t_path = os.path.expanduser(target)
    if os.path.lexists(l_path):
        try:
            if os.path.samefile(l_path, t_path):
                continue
            else:
                if os.path.islink(l_path) and args.force:
                    os.unlink(l_path)
                else:
                    print "Possible conflict on {}->{}".format(link,target)
                    continue
        except OSError as e:
            print "samefile check failed, probably means a dead symlink:", e
    try:
        os.symlink(os.path.join(script_dir, t_path), l_path)
    except OSError as e:
        print "Symlinking failed {}->{}".format(link,target), e

