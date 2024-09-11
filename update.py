#!/usr/bin/env python3

import os
import argparse

parser = argparse.ArgumentParser(description="Update and prepare dotfiles distribution")
parser.add_argument(
    "-f",
    "--force",
    action="store_true",
    help=(
        "Replace existing links, will *NOT* delete files or directories, and *WILL*"
        " error out if you ask it to"
    ),
)
args = parser.parse_args()

script_path = os.path.abspath(__file__)
script_dir = os.path.dirname(script_path)

os.chdir(script_dir)

link_files = {
    "gdbinit": "~/.gdbinit",
    "tridactylrc": "~/.tridactylrc",
    "pystartup.py": "~/.pystartup",
    "flake8": "~/.flake8",
    "ssh/config": "~/.ssh/config",
    "vim::orig": "~/.vim",
    "vim/vimrc": "~/.vimrc",
    "zsh": "~/.zsh",
    "zsh/zshenv-link": "~/.zshenv",
    "hammerspoon": "~/.hammerspoon",
    "tmux.conf": "~/.tmux.conf",
    "gitignore": "~/.gitignore",
    "gitconfig": "~/.gitconfig",
    "scripts": "~/scripts",
    "Xresources": "~/.Xresources",
    "vim::nvim": "~/.config/nvim",
    "pip": "~/.config/pip",
    "ptconfig.toml": "~/.ptconfig.toml",
    "mailmate/Resources": "~/Library/Application Support/MailMate/Resources",
    "mailmate/Bundles": "~/Library/Application Support/MailMate/Bundles",
    "emacs-redirect": "~/.emacs.d",
    "karabiner": "~/.config/karabiner",
}
if os.path.exists("~/Library"):
    link_files["pip"] = "~/Library/Application Support/pip"


def try_link(link, target):
    if "::" in target:
        target, _ = target.split("::")
    target = os.path.join(script_dir, target)
    print("linking {} to {}".format(link, target))
    l_path = os.path.expanduser(link)
    t_path = os.path.expanduser(target)
    if os.path.lexists(l_path):
        try:
            if os.path.islink(l_path) and args.force:
                os.unlink(l_path)
            else:
                if os.path.samefile(l_path, t_path):
                    return
                print("Possible conflict on {}->{}".format(link, target))
                return
        except OSError as e:
            print("samefile check failed, probably means a dead symlink:", e)
    try:
        os.makedirs(os.path.dirname(l_path))
    except OSError:
        pass
    try:
        relpath = os.path.relpath(t_path, os.path.dirname(l_path))
        os.symlink(relpath, l_path)
    except OSError as e:
        print("Symlinking failed {}->{}".format(link, target), e)


for target, link in link_files.items():
    try_link(link, target)

agents_dir = os.path.join(script_dir, "launch-agents")
for plist in os.listdir(agents_dir):
    try_link(
        os.path.join("~/Library/LaunchAgents/", os.path.basename(plist)),
        os.path.join(agents_dir, plist),
    )
