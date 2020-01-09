#!/usr/bin/python2

import subprocess
import distutils.spawn
import sys
import os
import string
import argparse
import shutil

parser = argparse.ArgumentParser(description='Update and prepare dotfiles distribution')
parser.add_argument('-f', '--force', action='store_true', help='Replace existing links, will *NOT* delete files or directories, and *WILL* error out if you ask it to')
args = parser.parse_args()

script_path =  os.path.abspath(__file__)
script_dir =  os.path.dirname(script_path)

os.chdir(script_dir)

#if not distutils.spawn.find_executable("brew"):
#    subprocess.call(["sh", "-c", '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'], stdout=sys.stdout, stderr=sys.stderr)
# subprocess.call(['git', 'pull'], stdout=sys.stdout, stderr=sys.stderr)
# subprocess.call(['git', 'submodule', 'update', '--init', '--recursive'], stdout=sys.stdout, stderr=sys.stderr)

link_files = {
        "pystartup.py" : "~/.pystartup",
        "ssh/config" : "~/.ssh/config",
        "vim" : "~/.vim",
        "vim/vimrc" : "~/.vimrc",
        "zsh" : "~/.zsh",
        "zsh/zshenv-link" : "~/.zshenv",
        "hammerspoon" : "~/.hammerspoon",
        # "mjolnir" : "~/.mjolnir",
        "tmux.conf" : "~/.tmux.conf",
        "gitignore" : "~/.gitignore",
        "gitconfig" : "~/.gitconfig",
        "scripts" : "~/scripts",
        "Xresources" : "~/.Xresources",
        "vim" : "~/.config/nvim",
        "pip" : "~/.config/pip",
        "ptconfig.toml" : "~/.ptconfig.toml",
        "mailmate/Gmail.plist" : "~/Library/Application Support/MailMate/Resources/KeyBindings/Gmail.plist",
        "mailmate/Liteetc.mmBundle" : "~/Library/Application Support/MailMate/Bundles/Liteetc.mmBundle",
        }
if os.path.exists("~/Library"):
    link_files["pip"] = "~/Library/Application Support/pip",

def try_link(link, target):
    print("linking {} to {}".format(link, target))
    l_path = os.path.expanduser(link)
    t_path = os.path.expanduser(target)
    if os.path.lexists(l_path):
        try:
            if os.path.samefile(l_path, t_path):
                return
            else:
                if os.path.islink(l_path) and args.force:
                    os.unlink(l_path)
                else:
                    print "Possible conflict on {}->{}".format(link,target)
                    return
        except OSError as e:
            print "samefile check failed, probably means a dead symlink:", e
    try:
        os.makedirs(os.path.dirname(l_path))
    except OSError:
        pass
    try:
        os.symlink(os.path.join(script_dir, t_path), l_path)
    except OSError as e:
        print "Symlinking failed {}->{}".format(link,target), e


for target, link in link_files.items():
    try_link(link, target)

agents_dir = os.path.join(script_dir, "launch-agents")
for plist in os.listdir(agents_dir):
    try_link(os.path.join("~/Library/LaunchAgents/", os.path.basename(plist)), os.path.join(agents_dir,plist))

