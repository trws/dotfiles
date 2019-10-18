;;; packages.el --- mnm layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Tom Scogland <scogland1@llnl.gov>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `mnm-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `mnm/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `mnm/pre-init-PACKAGE' and/or
;;   `mnm/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst mnm-packages
  '(notmuch)
  "The list of Lisp packages required by the mnm layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun mnm-toggle-tag (tag)
  "Toggle deleted tag for message."
  (if (member tag (notmuch-search-get-tags))
      (notmuch-search-tag (list (concat "-" tag)))
    (notmuch-search-tag (list (concat "+" tag))))
  (evil-next-line))

(defun mnm-toggle-delete () (interactive)(mnm-toggle-tag "delete"))
(defun mnm-toggle-unread () (interactive)(mnm-toggle-tag "unread"))
(defun mnm-toggle-flagged () (interactive)(mnm-toggle-tag "flagged"))
(defun mnm-toggle-inbox () (interactive)(mnm-toggle-tag "inbox"))
(defun mnm-toggle-killed () (interactive)(mnm-toggle-tag "killed"))

(defun mnm-save-attachments (mm-handle &optional queryp)
  (notmuch-foreach-mime-part
   (lambda (p)
     (let ((disposition (mm-handle-disposition p)))
       (and (listp disposition)
            (or (equal (car disposition) "attachment")
                (and (equal (car disposition) "inline")
                     (assq 'filename disposition)))
            (or (not queryp)
                (y-or-n-p
                 (concat "Save '" (cdr (assq 'filename disposition)) "' ")))
            (let ((path (concat "/tmp/" (cdr (assq 'filename disposition)))))
              (mm-save-part-to-file p path)
              (process-file "tmux" nil nil nil "split-window" "-v" "~/.iterm2/it2dl" path)
              ;; (shell-command (concat "~/.iterm2/it2dl " path))
              ))))
   mm-handle))

(defun mnm-show-save-attachments ()
  "Save all attachments from the current message."
  (interactive)
  (with-current-notmuch-show-message
   (let ((mm-handle (mm-dissect-buffer)))
     (mnm-save-attachments
      mm-handle (> (notmuch-count-attachments mm-handle) 1))))
  (message "Done"))


(defun local-notmuch-move ()
  "move message, remove inbox and add interactive tags"
  (interactive)
  (notmuch-search-tag (list "-inbox"))
  (notmuch-search-tag)
  (evil-next-line))

(defun local-notmuch-move (tag-changes &optional beg end)
  "Change tags for the current thread or region (defaulting to add).

Same as `notmuch-search-tag' but sets initial input to '-inbox +'."
  (interactive (notmuch-search-interactive-tag-changes "-inbox +"))
  (notmuch-search-tag tag-changes beg end))

(defun my-notmuch-go-to-inbox ()
  (interactive)
  (notmuch-search "tag:inbox AND NOT tag:killed" nil))
(defun my-notmuch-go-to-flagged ()
  (interactive)
  (notmuch-search "tag:flagged" nil))
(defun my-notmuch-go-to-sent ()
  (interactive)
  (notmuch-search "tag:sent" nil))
(defun my-run-sync ()
  (interactive)
  (shell-command "~/scripts/mail-tag")
  (shell-command "mbsync -a")
  (shell-command "~/scripts/mail-tag"))

;;; config keybindings
(defun mnm/post-init-notmuch ()
  (custom-set-variables
   '(notmuch-wash-citation-regexp
     (concat "\\("
             "^[[:space:]]*"
              "\\("
              "On .*wrote:[[:space:]]"
              "\\|"
              ">.*"
              "\\)"
             "\n"
             "\\)+"))
   '(notmuch-wash-signature-regexp "^\\(-- ?\\|_+\\|---+\\|~~~~+\\)$")
   '(notmuch-wash-original-regexp
     (concat "^\\("
             "\\(> \\)?--+\s?[oO]riginal [mM]essage\s?--+"
             "\\|"
             "____+"
             "\\|"
             "----------+"
             "\\|"
             "~~~~+"
             ;; "\\|"
             ;; " *On .*wrote:"
             "\\|"
             "From: .*>"
             "\\)$")))
  ;; Don't copy into sent for me, server does it
  (setq notmuch-fcc-dirs nil)
  ;; Show newest at top by default
  (setq notmuch-search-oldest-first nil)
  ;; don't keep random message buffers around
  (setq message-kill-buffer-on-exit t)
  (with-eval-after-load 'notmuch
    ;; (evil-define-key 'evilified notmuch-show-mode-map
    (evilified-state-evilify-map notmuch-show-mode-map
      :mode notmuch-show-mode
      :bindings
      (kbd "C-w h") 'evil-window-left
      (kbd "C-w j") 'evil-window-down
      (kbd "C-w k") 'evil-window-up
      (kbd "C-w l") 'evil-window-right
      (kbd "y") 'notmuch-show-archive-thread-then-exit
      (kbd "a") 'notmuch-show-reply
      (kbd "d") 'notmuch-show-advance
      (kbd "D") 'notmuch-show-advance-and-archive
      (kbd "n") 'evil-ex-search-next
      (kbd "N") 'evil-ex-search-previous
      (kbd "{") 'evil-backward-paragraph
      (kbd "}") 'evil-forward-paragraph
      (kbd "gi") 'my-notmuch-go-to-inbox
      (kbd "gs") 'my-notmuch-go-to-flagged
      (kbd "gS") 'my-notmuch-go-to-sent
      (kbd "gn") 'notmuch-show-next-message
      (kbd "gp") 'notmuch-show-previous-message
      (kbd "gN") 'notmuch-show-next-open-message
      (kbd "gP") 'notmuch-show-previous-open-message
      )
    ;; (evil-define-key 'evilified notmuch-search-mode-map
    (evilified-state-evilify-map
      notmuch-search-mode-map
      :mode notmuch-search-mode
      :bindings
      (kbd "S") 'my-run-sync
      (kbd "C-w h") 'evil-window-left
      (kbd "C-w j") 'evil-window-down
      (kbd "C-w k") 'evil-window-up
      (kbd "C-w l") 'evil-window-right
      (kbd "gi") 'my-notmuch-go-to-inbox
      (kbd "gs") 'my-notmuch-go-to-flagged
      (kbd "gS") 'my-notmuch-go-to-sent
      (kbd "$") 'notmuch-refresh-this-buffer
      (kbd "y") 'mnm-toggle-inbox
      (kbd "e") 'mnm-toggle-inbox
      (kbd "#") 'mnm-toggle-delete
      (kbd "U") 'mnm-toggle-unread
      (kbd "s") 'mnm-toggle-flagged
      (kbd "v") 'local-notmuch-move
      (kbd "a") 'notmuch-search-reply-to-thread
      ))
  )
;;; packages.el ends here
