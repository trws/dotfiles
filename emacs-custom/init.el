(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq custom-file (replace-regexp-in-string "init.el$" "custom.el" user-init-file))
(load custom-file)
(setq osc52-file (replace-regexp-in-string "init.el$" "osc52e.el" user-init-file))
(load osc52-file)
(osc52-set-cut-function)


(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.dotfiles/emacs-custom/use-package/")
  (require 'use-package))
(define-key universal-argument-map (kbd "C-u") nil)
(define-key global-map (kbd "C-u") 'evil-scroll-up)


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
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
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
  (setq evil-collection-company-use-tng t)
  :config
  (evil-collection-init))

(use-package evil-surround ;; surround all the things
  :ensure t)

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode)
  :general
  (:states 'insert
	   "C-SPC" 'company-complete))

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

					; (defvar application-map (make-sparse-keymap)
					;     "Keymap for \"leader key\" shortcuts.")


(gleader "/" 'swiper)
(gleader :wk-full-keys nil
  "a" '(:prefix-map app-prefix-map
		    :prefix-command app-prefix-command
		    :which-key "applications prefix"))

(general-define-key
 :prefix-command 'app-prefix-command
 :prefix-map 'app-prefix-map
 "N" '(:prefix-map nm-app-prefix-map
		   :prefix-command nm-app-prefix-command
		   :which-key "applications prefix"))

(general-define-key
 :prefix-command 'nm-app-prefix-command
 :prefix-map 'nm-app-prefix-map
 "i" 'my-notmuch-go-to-inbox
 "f" 'my-notmuch-go-to-flagged
 "s" 'my-notmuch-go-to-sent
 )

(use-package org
  :ensure t
  :config
  (use-package ob-go :ensure t)
  (use-package ob-rust :ensure t)
  (use-package ob-tmux :ensure t)
  (use-package ob-hy :ensure t)
  (org-defkey org-mode-map [(meta return)] 'org-meta-return)  ;; The actual fix
  (setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-agenda-tags-todo-honor-ignore-options t)

  (setq org-archive-location "~/Box Sync/scogland1/documents/org/archive.org::* From %s" )
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
  ;; smtp mail setting; these are the same that `gnus' uses.
  (setq notmuch-wash-wrap-lines-length 88
	notmuch-message-deleted-tags '("+delete" "-inbox" "-unread")
	notmuch-tagging-keys '(("a" notmuch-archive-tags "Archive")
			       ("u" notmuch-show-mark-read-tags "Mark read")
			       ("f" ("+flagged") "Flag")
			       ("s" ("+spam" "-inbox") "Mark as spam")
			       ("c" ("+conference" "-inbox" "-unread") "Mark as conf and archive")
			       ("t" ("+travel" "-inbox" "-unread") "Mark as travel and archive")
			       ("n" ("+news" "-inbox" "-unread") "Mark as news and archive")
			       ("d"
				("+deleted" "-inbox" "-unread")
				"Delete")
			       ("m" ("+killed") "Mute/Kill thread")))
  (setq message-send-mail-function 'smtpmail-send-it
	smtpmail-default-smtp-server "smtp.office365.com"
	smtpmail-smtp-server "smtp.office365.com"
	smtpmail-local-domain "llnl.gov"
	smtpmail-stream-type 'starttls
	smtpmail-smtp-service 587)
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
(defun my-run-sync ()
  (interactive)
  (shell-command "~/scripts/mail-tag")
  (shell-command "mbsync -a")
  (shell-command "~/scripts/mail-tag"))





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
