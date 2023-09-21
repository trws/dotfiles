(setq user-init-file "~/.cache/doom-emacs/early-init.el")
(setq user-emacs-directory  "~/.cache/doom-emacs")
(if (not (file-directory-p user-emacs-directory))
  (progn
    (shell-command "mkdir -p ~/.cache")
    (shell-command "git clone https://github.com/hlissner/doom-emacs ~/.cache/doom-emacs")))
(if (not (getenv "DOOMLOCALDIR"))
  (setenv "DOOMLOCALDIR" "~/.cache/doom-local"))
(if (not (getenv "DOOMDIR"))
  (setenv "DOOMDIR" "~/.dotfiles/doom"))

(load user-init-file)
