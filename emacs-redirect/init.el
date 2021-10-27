(setq user-init-file "~/.dotfiles/doom-emacs/init.el")
(setq user-emacs-directory  "~/.dotfiles/doom-emacs")
(if (not (getenv "DOOMLOCALDIR"))
  (setenv "DOOMLOCALDIR" "~/.cache/doom-local"))
(if (not (getenv "DOOMDIR"))
  (setenv "DOOMDIR" "~/.dotfiles/doom"))

(load  "~/.dotfiles/doom-emacs/init.el")
