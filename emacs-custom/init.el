(setq user-init-file (file-truename (or load-file-name (buffer-file-name))))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq custom-file (replace-regexp-in-string "init.el$" "custom.el" user-init-file))
(load custom-file)
(setq osc52-file (replace-regexp-in-string "init.el$" "osc52e.el" user-init-file))
(load osc52-file)
(osc52-set-cut-function)

(setq package-user-dir "~/.cache/emacs/packages")
(mkdir package-user-dir t)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ;; work around stupid bug
(package-initialize)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.dotfiles/emacs-custom/use-package/")
  (require 'use-package))
(define-key universal-argument-map (kbd "C-u") nil)
(define-key global-map (kbd "C-u") 'evil-scroll-up)
(define-key global-map (kbd "C-@") 'counsel-company)
(define-key global-map (kbd "C-SPC") 'counsel-company)
(define-key global-map (kbd "C-<escape>") 'evil-normal-state)




;; ITERM2 MOUSE SUPPORT
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  (mouse-wheel-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (menu-bar-mode -1))

(use-package gnu-elpa-keyring-update :ensure t)
(use-package paradox :ensure t
  :init
  :config
  (paradox-enable))

(use-package key-chord :ensure t
					; :defer 1 ; do not load right at startup
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-mode 1)
  )
(use-package general
  :ensure t
  :config
  (general-evil-setup t))

;; (use-package evil-tabs
;;   :ensure t
;;   :config
;;   (global-evil-tabs-mode t))



(use-package format-all
  :ensure t)
(defun my-indent-file ()
  (interactive)
  ;; (indent-region (point-min) (point-max))
  (format-all-buffer)
  )
(use-package evil
  :ensure t
  :after general
  :init
  ;; (setq evil-want-keybinding nil)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  :config
  (evil-mode 1)
  (setq evil-intercept-esc 'always)
  :general
  (:states '(normal insert)
	   "C-k" 'my-indent-file)
  ;; (:states 'normal
  ;; 	   "C-u" 'evil-scroll-half-page-up)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :init
  ;; (setq evil-want-keybinding nil)
  (setq evil-collection-company-use-tng t)
  :config
  (evil-collection-init))

(use-package evil-surround ;; surround all the things
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode)
;;   :general
;;   (:states 'insert
;; 	   "C-SPC" 'company-complete
;; 	   "C-@" 'company-complete)
)
;; (use-package company-fuzzy
;;   :ensure t
;;   :after flx
;;   :config
;;   (setq company-fuzzy-sorting-backend 'flx)
;;   (global-company-fuzzy-mode))

;; (use-package fuzzy
;; :ensure t)
;; (use-package auto-complete
;; :ensure t
;; :after fuzzy
;; :config
;; (setq ac-fuzzy-enable t)
;; (setq ac-use-fuzzy t)
;; :init
;; (progn
;; (ac-config-default)
;; (global-auto-complete-mode t)
;; ))

;; window movement
(general-def :states 'normal :keymaps 'override "M-h" 'evil-window-left)
(general-def :states 'normal :keymaps 'override "M-j" 'evil-window-down)
(general-def :states 'normal :keymaps 'override "M-k" 'evil-window-up)
(general-def :states 'normal :keymaps 'override "M-l" 'evil-window-right)

(general-def :states '(insert normal) :keymaps 'override "<home>" 'evil-beginning-of-visual-line)
(general-def :states '(insert normal) :keymaps 'override "<end>" 'evil-end-of-line-or-visual-line)

;; easy esc
(general-imap "j"
  (general-key-dispatch 'self-insert-command
    :timeout 0.15
    "k" 'evil-normal-state))
(general-imap "k"
  (general-key-dispatch 'self-insert-command
    :timeout 0.15
    "j" 'evil-normal-state))

;; Leader setup and general mappings
;; for frequently used prefix keys, the user can create a custom definer with a
;; default :prefix
;; using a variable is not necessary, but it may be useful if you want to
;; experiment with different prefix keys and aren't using `general-create-definer'
(defconst global-leader "SPC")
(defconst local-leader ",")

(general-create-definer gleader
  :states '(normal insert emacs)
  :prefix global-leader
  :non-normal-prefix (concat "M-" global-leader)
  )
(gleader "" nil)

(general-create-definer lleader
  :states '(normal insert emacs)
  :prefix local-leader
  :non-normal-prefix (concat "M-" local-leader)
  )
(lleader "" nil)

(gleader "/" 'swiper)
(gleader :wk-full-keys nil
  "a" '(:prefix-map app-prefix-map
		    :prefix-command app-prefix-command
		    :which-key "applications prefix")
  "o" '(:prefix-map org-prefix-map
		    :prefix-command org-prefix-command
		    :which-key "org mode")
  "b" '(:prefix-map buffer-prefix-map
		    :prefix-command buffer-prefix-command
		    :which-key "buffer operations")
  "f" '(:prefix-map file-prefix-map
		    :prefix-command file-prefix-command
		    :which-key "buffer operations")
  )
(defun my-open-cfg ()
  (interactive)
  (evil-window-vsplit :FILE user-init-file))
(defun my-open-index ()
  (interactive)
  (evil-window-vsplit :FILE my-org-inbox))
(general-define-key
 :prefix-command 'org-prefix-command
 :prefix-map 'org-prefix-map
 "o" '(lambda () (interactive) (evil-window-vsplit :FILE my-org-inbox))
 "a" 'org-agenda
 )
(general-define-key
 :prefix-command 'org-ins-prefix-command
 :prefix-map 'org-ins-prefix-map
 "o" '(lambda () (interactive) (evil-window-vsplit :FILE my-org-inbox))
 )

(general-define-key
 :prefix-command 'app-prefix-command
 :prefix-map 'app-prefix-map
 "N" '(:prefix-map nm-app-prefix-map
		   :prefix-command nm-app-prefix-command
		   :which-key "applications prefix")
 "s" '(:prefix-map slack-app-prefix-map
		   :prefix-command slack-app-prefix-command
		   :which-key "applications prefix")
 )

(general-define-key
 :prefix-command 'nm-app-prefix-command
 :prefix-map 'nm-app-prefix-map
 "i" 'my-notmuch-go-to-inbox
 "f" 'my-notmuch-go-to-flagged
 "s" 'my-notmuch-go-to-sent
 )

(general-define-key
 :prefix-command 'slack-app-prefix-command
 :prefix-map 'slack-app-prefix-map
 "r" 'slack-select-rooms
 "s" 'slack-start
 "t" 'slack-change-current-team
 )

(defun my-kill-this-buffer ()
  "Kill the current buffer"
  (interactive)
  (kill-buffer (current-buffer)))

(general-define-key
 :prefix-command 'buffer-prefix-command
 :prefix-map 'buffer-prefix-map
 "x" 'my-kill-this-buffer
 "k" 'kill-buffer
 "q" 'kill-buffer-and-window)

(general-define-key
 :prefix-command 'file-prefix-command
 :prefix-map 'file-prefix-map
 "c" 'my-open-cfg)

(define-key global-map "\C-cl" 'org-store-link)

(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

(setq my-org-inbox "~/onedrive/org/inbox.org")
(use-package org
  :ensure org-plus-contrib
  :init
  (setq org-return-follows-link t)
  :general
  (gleader "c" 'org-capture)
  (lleader
    "T" 'counsel-org-tag
    "t" 'org-set-tags-command
    "r" 'org-refile
    "d" 'org-deadline
    "s" 'org-schedule
    )
  :config
  (use-package ob-go :ensure t)
  (use-package ob-rust :ensure t)
  (use-package ob-tmux :ensure t)
  (use-package ob-hy :ensure t)
  (require 'ol-notmuch)
  (org-defkey org-mode-map [(meta return)] 'org-meta-return)  ;; The actual fix

  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
  (setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-agenda-tags-todo-honor-ignore-options t)
  (setq org-agenda-window-setup 'other-window)
  (setq org-log-done 'time)

  (setq org-refile-targets
	`((,my-org-inbox :maxlevel . 2)))
  (setq org-archive-location "~/onedrive/org/archive.org::* From %s" )
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (python . t)
     (rust . t)
     (go . t)
     (tmux . t)
     (clojure . t)
     (hy . t)
     (C . t)
     (R . t)))
  (setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-agenda-tags-todo-honor-ignore-options t)

  (setq org-archive-location "~/onedrive/org/archive.org::* From %s" )
  ;; (evil-define-key 'normal evil-org-mode-map
  ;;   ;;   (kbd "<C-return>") (evil-org-define-eol-command
  ;;   ;;                       org-insert-heading-respect-content)
  ;;   (kbd "<M-t>") (evil-org-define-eol-command
  ;; 		   org-insert-todo-heading-respect-content)
  ;;   (kbd "<M-left>") 'org-metaleft
  ;;   )
  (setq org-capture-templates
	'(("c" "Todo capture context" entry (file+headline "~/onedrive/org/inbox.org" "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("t" "Todo" entry (file+headline "~/onedrive/org/inbox.org" "Tasks")
	   "* TODO %?" :empty-lines 1)
	  ("n" "Notes" entry (file+headline "~/onedrive/org/inbox.org" "Notes")
	   "* %?\n  %i\n  %a")
	  ;; ("j" "Journal" entry (file+datetree "~/org/journal.org")
	  ;;  "* %?\nEntered on %U\n  %i\n  %a")
	  ))
  (setq org-agenda-files '("~/onedrive/org/" ))
  )

(use-package evil-org
  :ensure t
  :after org
  :init
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme '(navigation insert textobjects additional calendar))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :general
  (gleader "p" '(:prefix-map projectile-command-map)))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

(defun lmc ()
  (interactive)
  (load-file user-init-file))



;; for immensely better completion sorting
(use-package flx
  :ensure t)
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :ensure t
  :after flx
  :config
  (setq ivy-re-builders-alist
	'((t . ivy--regex-fuzzy)))
					; default
  ;; ((spacemacs/counsel-search . spacemacs/ivy--regex-plus)
					; (t . ivy--regex-ignore-order))
  (setq ivy-wrap t)
  (ivy-mode 1)
  :bind
  (("C-c C-r" . 'ivy-resume)
   ("<f6>" . 'ivy-resume)
   ))
(use-package counsel
  :ensure t
  :bind
  (("M-x" . 'counsel-M-x)
   ("C-x C-f" . 'counsel-find-file)
   ("<f1> f" . 'counsel-describe-function)
   ("<f1> v" . 'counsel-describe-variable)
   ("<f1> b" . 'counsel-descbinds)
   ("<f1> l" . 'counsel-find-library)
   ("<f2> i" . 'counsel-info-lookup-symbol)
   ("<f2> u" . 'counsel-unicode-char)
   ("C-c g" . 'counsel-git)
   ("C-c j" . 'counsel-git-grep)
   ("C-c k" . 'counsel-ag)
   ("C-x l" . 'counsel-locate)
   ("C-S-o" . 'counsel-rhythmbox)
   :map minibuffer-local-map
   ("C-r" . 'counsel-minibuffer-history)
   ))
(use-package swiper
  :ensure t
  :bind
  (("\C-s" . 'swiper)
   ))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package notmuch
  :ensure t
  :after general
  :init
  ;; Don't copy into sent for me, server does it
  (setq notmuch-fcc-dirs nil)
  ;; Show newest at top by default
  (setq notmuch-search-oldest-first nil)
  ;; don't keep random message buffers around
  (setq message-kill-buffer-on-exit t)
  (setq message-bogus-addresses
  '("noreply.?[^g]?" "nospam" "invalid" "@.*@" "[^[:ascii:]].*@" "[ \t]"))
  (setq notmuch-poll-script "~/scripts/mail-sync-freq")
  ;; smtp mail setting; these are the same that `gnus' uses.
  (setq notmuch-message-headers '("Subject" "To" "Cc" "Date" "Mailer")
	notmuch-wash-wrap-lines-length 88
	notmuch-wash-original-regexp (concat "^\\("
					     "\\(> \\)?--+\s?[oO]riginal [mM]essage\s?--+"
					     "\\|"
					     "\\("
						"_______+\n"
						"From: .*>.*"
					     "\\)"
					     "\\|"
					     "----------+"
					     "\\|"
					     "Sent from my iPhone"
					     "\\|"
					     "~~~~+"
					     ;; "\\|"
					     ;; " *On .*wrote:"
					     "\\|"
					     "﻿On.*wrote:"
					     "\\|"
					     "From: .*>"
					     "\\)$")
	notmuch-message-deleted-tags '("+delete" "-inbox" "-unread")
	notmuch-tagging-keys '(("a" notmuch-archive-tags "Archive")
			       ("u" notmuch-show-mark-read-tags "Mark read")
			       ("f" ("+flagged") "Flag")
			       ("F" ("-flagged") "Remove Flag")
			       ("s" ("+spam" "-inbox") "Mark as spam")
			       ("c" ("+conference" "-inbox" "-unread") "Mark as conf and archive")
			       ("t" ("+travel" "-inbox" "-unread") "Mark as travel and archive")
			       ("n" ("+news" "-inbox" "-unread") "Mark as news and archive")
			       ("d"
				("+deleted" "-inbox" "-unread")
				"Delete")
			       ("m" ("+killed") "Mute/Kill thread")))
  (setq message-send-mail-function 'message-send-mail-with-sendmail)
  (setq sendmail-program "msmtp")
  (setq message-sendmail-extra-arguments '("-t" "-a" "llnl"))
  ; (setq message-send-mail-function 'smtpmail-send-it
	; smtpmail-default-smtp-server "smtp.office365.com"
	; smtpmail-smtp-server "smtp.office365.com"
	; smtpmail-local-domain "llnl.gov"
	; smtpmail-stream-type 'starttls
	; smtpmail-smtp-service 587)
  :general
  (:states 'normal
	   :keymaps 'notmuch-common-keymap
	   (general-chord "gi") 'my-notmuch-go-to-inbox
	   (general-chord "gs") 'my-notmuch-go-to-flagged
	   (general-chord "gS") 'my-notmuch-go-to-sent)
  (:states 'normal
	   :keymaps 'notmuch-search-mode-map
	   "$" 'notmuch-refresh-this-buffer
	   "e" 'mnm-search-tog-inbox
	   "y" 'mnm-search-tog-inbox
	   "v" 'mnm-search-move
	   "r" 'notmuch-search-reply-to-thread-sender
	   "a" 'notmuch-search-reply-to-thread
	   )
  (:states 'normal
	   :keymaps 'notmuch-show-mode-map
	   "C-u" 'evil-scroll-page-up
	   "e" 'notmuch-show-archive-thread-then-exit
	   "r" 'notmuch-show-reply-sender
	   "a" 'notmuch-show-reply
	   "d" 'notmuch-show-advance
	   "D" 'notmuch-show-advance-and-archive)
  (lleader :keymaps 'notmuch-show-mode-map
    "" nil
    "f" 'notmuch-show-forward-message
    "r" 'notmuch-show-reply-sender
    "a" 'notmuch-show-reply
    )
  )
;; Modify command completion behavior to be less alien
(setq completion-styles '(basic partial-completion emacs22 initials))

(use-package counsel-notmuch
  :after notmuch counsel
  :ensure t)


(defmacro make-toggle (tag)
  `(progn
     ,@(let ((modes '("show" "search"))
             (funs '()))
         (while modes
	   (let ((fn (intern (format "mnm-%s-toggle-%s" (car modes) tag))))
	     (setq funs (cons `(defun ,fn ()
				 (interactive)
				 (evil-collection-notmuch-toggle-tag ,tag ,@(car modes))) funs))
	     (setq modes (cdr modes))))
         funs)))
(defun mnm-search-tog-inbox ()
  (interactive)
  (evil-collection-notmuch-toggle-tag "inbox" "search" 'notmuch-search-next-thread))
(make-toggle "inbox")
(make-toggle "killed")

(defun mnm-search-move ()
  "move message, remove inbox and add interactive tags"
  (interactive)
  (notmuch-search-tag (list "-inbox"))
  (notmuch-search-tag)
  (evil-next-line))

(defun my-notmuch-go-to-inbox ()
  (interactive)
  (notmuch-search "tag:inbox AND NOT tag:killed" nil))
(defun my-notmuch-go-to-flagged ()
  (interactive)
  (notmuch-search "tag:flagged" nil))
(defun my-notmuch-go-to-sent ()
  (interactive)
  (notmuch-search "tag:sent" nil))
(defun my-run-sync-freq ()
  (interactive)
  (shell-command "~/scripts/mail-sync frequent")
  )
(defun my-run-sync-occ ()
  (interactive)
  (shell-command "~/scripts/mail-sync occasional")
  )





					; (use-package helm
					;              :ensure t)
					; (require 'helm-config)

(use-package eww
  :ensure t)

					; File types
(use-package vimrc-mode
  :ensure t)


(use-package jbeans-theme
  :ensure t)
(load-theme 'jbeans t)

;; (use-package el-get
;;   :ensure t)
;; (el-get-bundle slack)
(use-package slack
  :ensure t
  :commands (slack-start)
  :init
  ;; (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "llnl-performance"
   :default t
   :token (with-temp-buffer
    (insert-file-contents "~/.config/emacs-slack-token" )
    (buffer-string))
   :subscribed-channels '(flux general herbein1)
   :full-and-display-names t)

  (slack-register-team
   :name "llnl"
   :token (with-temp-buffer
    (insert-file-contents "~/.config/emacs-slack-llnl-token" )
    (buffer-string))
   :subscribed-channels '(general))

  (slack-register-team
   :name "kokkos"
   :token (with-temp-buffer
    (insert-file-contents "~/.config/emacs-slack-kokkos-token" )
    (buffer-string))
   :subscribed-channels '(general))

  (evil-define-key 'normal slack-info-mode-map
    ",u" 'slack-room-update-messages)
  (evil-define-key 'normal slack-mode-map
    ",c" 'slack-buffer-kill
    ",ra" 'slack-message-add-reaction
    ",rr" 'slack-message-remove-reaction
    ",rs" 'slack-message-show-reaction-users
    ",pl" 'slack-room-pins-list
    ",pa" 'slack-message-pins-add
    ",pr" 'slack-message-pins-remove
    ",mm" 'slack-message-write-another-buffer
    ",me" 'slack-message-edit
    ",md" 'slack-message-delete
    ",u" 'slack-room-update-messages
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel
    "\C-n" 'slack-buffer-goto-next-message
    "\C-p" 'slack-buffer-goto-prev-message)
   (evil-define-key 'normal slack-edit-message-mode-map
    ",k" 'slack-message-cancel-edit
    ",s" 'slack-message-send-from-buffer
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel))

(use-package centaur-tabs
  :ensure t
  :config
  (centaur-tabs-mode t)
  (defun centaur-tabs-buffer-groups ()
     "`centaur-tabs-buffer-groups' control buffers' group rules.
 Group comms (notmuch and slack) based on name, others together excepting emacs buffers,
  centaur-tabs with mode if buffer is derived from `eshell-mode'
 `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.  All buffer
 name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
     (list
      (cond
	;; ((not (eq (file-remote-p (buffer-file-name)) nil))
	;; "Remote")
	((or (string-equal "*not" (substring (buffer-name) 0 4))
	     )
	 "Email")
	((derived-mode-p 'slack-mode)
	 "Slack")
	((or (string-equal "*" (substring (buffer-name) 0 1))
	     (memq major-mode '(magit-process-mode
				magit-status-mode
				magit-diff-mode
				magit-log-mode
				magit-file-mode
				magit-blob-mode
				magit-blame-mode
				)))
	 "Emacs")
	((derived-mode-p 'prog-mode)
	 "Editing")
	((derived-mode-p 'dired-mode)
	 "Dired")
	((memq major-mode '(helpful-mode
			    help-mode))
	 "Help")
	((memq major-mode '(org-mode
			    org-agenda-clockreport-mode
			    org-src-mode
			    org-agenda-mode
			    org-beamer-mode
			    org-indent-mode
			    org-bullets-mode
			    org-cdlatex-mode
			    org-agenda-log-mode
			    diary-mode))
	 "OrgMode")
	(t
	 (centaur-tabs-get-group-name (current-buffer))))))
  :bind
  (:map evil-normal-state-map
	     ("g t" . centaur-tabs-forward)
	     ("g T" . centaur-tabs-backward)
	     ("M-}" . centaur-tabs-forward)
	     ("M-{" . centaur-tabs-backward)))
