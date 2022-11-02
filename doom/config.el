;;; $doomdir/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(eval-when-compile (require 'cl-lib)
                   (require 'dash))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tom Scogland"
      user-mail-address "scogland1@llnl.gov")

(setq browse-url-browser-function ( if (eq system-type 'darwin)
                                      'browse-url-default-macosx-browser
                                      'browse-url-xdg-open
                                      ))
(defun my-browse-url-on-client (URL &optional IGNORED)
  (print (format "\033]1337;Custom=id=%s:%s:%s\a" "url-open-sec" "open-link" URL) #'external-debugging-output))
(defun my-toggle-url-handler ()
  (interactive)
  (if (= browse-url-browser-function 'browse-url-xdg-open)
      (setq browse-url-browser-function 'my-browse-url-on-client)
      (setq browse-url-browser-function 'browse-url-xdg-open)))

(unless window-system
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(catch 'break
  (dolist (f '("FiraCode Nerd Font" "ProFontIIx Nerd Font Mono" "ProFontIIx NF"  "monospace"))
    (if (find-font (font-spec :family f))
        (progn
          (setq doom-font (font-spec :family f :size 10))
          (throw 'break t)))))
                                        ; (setq doom-font (font-spec :family "ProFont IIx Nerd Font Mono" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'adwaita) ;; oddly nice light theme, odd blue highlight on current line
;; (setq doom-theme 'misterioso) ;; a bit like wombat, slightly lighter background
;; (setq doom-theme 'wombat) ;; nice greenish dark theme
;; (setq doom-theme 'sourcerer) ;; current best match for apprentice
(setq doom-apprentice-brighter-comments nil)
(setq doom-theme 'doom-apprentice) ;; my rework to get us apprentice


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(load! "org-config.el")
;; org-gtd needs some doom stuff


(map! :map 'override
      :ni "M-w" 'evil-quit
      :ni "M-h" 'evil-window-left
      :ni "M-j" 'evil-window-down
      :ni "M-k" 'evil-window-up
      :ni "M-l" 'evil-window-right
      :ni "A-w" 'evil-quit
      :ni "A-h" 'evil-window-left
      :ni "A-j" 'evil-window-down
      :ni "A-k" 'evil-window-up
      :ni "A-l" 'evil-window-right
      )

;; (dolist (m '(override notmuch-common-keymap org-agenda-mode-map))
;;   (map! :map 'override
;;         :ni "M-w" 'evil-quit
;;         :ni "M-h" 'evil-window-left
;;         :ni "M-j" 'evil-window-down
;;         :ni "M-k" 'evil-window-up
;;         :ni "M-l" 'evil-window-right
;;         :ni "A-w" 'evil-quit
;;         :ni "A-h" 'evil-window-left
;;         :ni "A-j" 'evil-window-down
;;         :ni "A-k" 'evil-window-up
;;         :ni "A-l" 'evil-window-right
;;         ))


(after! org
  (defun org-archive-done-tasks ()
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
     "/DONE" 'tree)))

;; calendar stuff _ NOTE: broken on emacs 28 in gcc mode
;; (use-package excorporate
;;   :config
;;   (setq excorporate-configuration (quote ("scogland1@llnl.gov" . "https://outlook.office365.com/EWS/Exchange.asmx"))
;;         org-agenda-include-diary t
;;         ))

;; Key Chords
(use-package! key-chord
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-mode 1)
  )

; (use-package! org-roam
;   :after org
;   :config
;   (setq org-roam-directory (expand-file-name "~/org")))
; (use-package! org-logseq
;   :after org
;   :config
;   (setq org-logseq-dir (expand-file-name "~/org"))
;   (setq org-logseq-block-ref-overlay-p t))

;; NotMuch email config
(setq gnus-select-method
      '(nnmaildir ""
                  (directory "~/Mail/scogland1/")
                  (get-new-mail nil)))
(defmacro keylambda (body)
  `(lambda () (interactive) ,body))
(use-package! mu4e-icalendar
  :if (executable-find "mu")
  :after mu4e
  :config
  (mu4e-icalendar-setup))

(defun my-contact-processor (contact)
  (cond
   ;; remove unwanted mailing list rewrites, etc.
   ((string-match-p " via " contact) (replace-regexp-in-string "^.+ via " "" contact))
   ((string-match-p "bounces" contact) nil)
   ((string-match-p "mailman.openmp.org" contact) nil)
   ((string-match-p "mail.openmp.org" contact) nil)
   ((string-match-p "-request@" contact) nil)
   ((string-match-p "noreply" contact) nil)
   ((string-match-p "no-reply" contact) nil)
   ;;
   ;; jonh smiht --> John Smith
   ((string-match "@.+<.+@.+>" contact)
    (replace-regexp-in-string ".+<\\(.+\\)>" "\\1" contact))
   (t contact)))

(defun my-mu4e-url-shortcut ()
  (interactive)
  (let ((urls (catch 'stop-mapping
                (maphash (lambda (key value)
                           (if (string-match-p "github.com/[^ $]+\\(pull\\|issue\\)" value)
                               (throw 'stop-mapping (list value)))
                           value)
                         mu4e~view-link-map))))
    (if (= (length urls) 1)
        (mu4e~view-browse-url-from-binding (car urls))
      (mu4e-view-go-to-url))
    ))

(use-package! mu4e
  :if (executable-find "mu")
  :config
  ;; (use-package! org-mu4e)
  (defun view-attachment-vsplit  (msg num)
    (evil-window-vsplit)
    (mu4e-view-open-attachment-emacs msg num))
  (defun view-attachment-hsplit  (msg num)
    (evil-window-split)
    (mu4e-view-open-attachment-emacs msg num))
  (setq!
   mu4e-maildir (expand-file-name "~/Mail/scogland1")
   mu4e-attachment-dir (expand-file-name "~/Downloads")
   mu4e-view-use-gnus t
   mu4e-get-mail-command  "true"
   mu4e-update-interval 600
   mu4e-index-lazy-check t
   mu4e-headers-skip-duplicates t
   hl-line-sticky-flag t ;; make mu4e header highlight work while reading messages
   mu4e-headers-fields '((:account . 6)
                         (:human-date . 12)
                         (:flags . 6)
                         (:from-or-to . 25)
                         (:tags . 10)
                         (:subject)))
  (add-to-list 'mu4e-marks
               '(tag
                 :char       ("g" . "t")
                 :prompt     "gtag"
                 :ask-target (lambda () (read-string "What tag do you want to add?"))
                 :action      (lambda (docid msg target)
		                (mu4e-action-retag-message msg (concat "+" target))
                                (mu4e~proc-move docid (mu4e-msg-field msg :maildir)))))

  (add-to-list 'mu4e-marks
               '(flagrefile
                 :char ("E". "E")
                 :prompt     "Flag and Refile"
                 :show-target (lambda (target) "Flag and refile")
                 :dyn-target
                 (lambda
                   (target msg)
                   (mu4e-get-refile-folder msg))
                 :action
                 (lambda
                   (docid msg target)
                   (mu4e~proc-move docid
                                   (mu4e~mark-check-target target) "+F-N"))))
  (mu4e~headers-defun-mark-for flagrefile)
  (add-to-list 'mu4e-marks
               '(unflagrefile
                 :char ("Y". "Y")
                 :prompt     "Unflag and Refile"
                 :show-target (lambda (target) "unflag and refile")
                 :dyn-target
                 (lambda
                   (target msg)
                   (mu4e-get-refile-folder msg))
                 :action
                 (lambda
                   (docid msg target)
                   (mu4e~proc-move docid
                                   (mu4e~mark-check-target target) "-F-N"))))
  (mu4e~headers-defun-mark-for unflagrefile)
  (setq mu4e-refile-folder
        (lambda (msg)
          (cond
           ;; messages to hpc-announce mailing list and other conf announces
           ((or (mu4e-message-contact-field-matches msg :to
	                                            "hpc-announce@mcs.anl.gov")
                (mu4e-message-contact-field-matches msg :from
	                                            "call-for-papers@hq.acm.org"))
	    "/conferences")
           ;; messages from Newsline go to news
           ((string-match "Newsline"
	                  (mu4e-message-field msg :subject))
	    "/News")

           ;; messages sent by me go to the sent folder
           ;; ((find-if
	   ;;   (lambda (addr)
	   ;;     (mu4e-message-contact-field-matches msg :from addr))
	   ;;   (mu4e-personal-addresses))
	   ;;  mu4e-sent-folder)
           ;; everything else goes to /archive

           ;; important to have a catch-all at the end!
           (t  "/archive"))))
  (setq mu4e-compose-complete-only-personal nil)

  (setq mu4e-contact-process-function 'my-contact-processor)
  (add-to-list 'mu4e-view-attachment-actions
               '("vin-emacs-vsplit" . view-attachment-vsplit))
  (add-to-list 'mu4e-view-attachment-actions
               '("hin-emacs-hsplit" . view-attachment-hsplit))
  (add-to-list 'mu4e-bookmarks '(:name "Flagged"
                                 :query "flag:flagged"
                                 :key ?f ))
  ;; (use-package! mu4e-conversation)
  (add-hook 'mu4e-view-mode-hook 'visual-line-mode)
  (add-hook 'mu4e-view-mode-hook 'visual-fill-column-mode)
  (map! :map 'mu4e-headers-mode-map
        :n "e" 'mu4e-headers-mark-for-refile
        :n "Y" 'mu4e-headers-mark-for-unflagrefile
        :n "E" 'mu4e-headers-mark-for-flagrefile
        :n "#" 'mu4e-headers-mark-for-delete
        ;; :n "$" 'mu4e-headers-rerun-search
        :n "X" 'mu4e-headers-mark-thread
        :n "gi" (keylambda (mu4e~headers-jump-to-maildir "/INBOX"))
        :n "gs" (keylambda (mu4e-headers-search "flag:flagged"))
        :n "gS" (keylambda (mu4e~headers-jump-to-maildir "/sent"))
        )
  (map! :map 'mu4e-view-mode-map
        :n "J" 'mu4e-view-headers-next
        :n "K" 'mu4e-view-headers-prev
        :n "C-o" 'my-mu4e-url-shortcut
        )
  (map! :leader
        :desc "Toggle visual wrap to fill"
        "b W" 'visual-fill-column-mode)


  ;; from https://emacs.stackexchange.com/questions/52894/how-to-open-text-links-hypertext-firefox-with-mu4e
  ;; why this isn't part of upstream I have no idea, make html email links work
  (setq mu4e-html2text-command 'mu4e-shr2text)

  (defun mu4e-make-hypertext-clickable ()
    (let ((next-url
           (lambda ()
             (ignore-errors
               (goto-char (next-single-property-change (point) 'shr-url))))))
      (save-excursion
        ;; Do nothing if no anchors are found
        (when (funcall next-url)
          (setq mu4e~view-link-map            ; buffer local
                (make-hash-table :size 32 :weakness nil))
          (let ((c 0))
            (remove-overlays)
            (goto-char (point-min))
            (while (funcall next-url)
              (let ((ov (make-overlay (point) (point)))
                    (num (cl-incf c))
                    (url (shr-url-at-point nil)))
                (puthash num url mu4e~view-link-map)
                (overlay-put ov 'before-string
                             (propertize (format "[%d]" num)
                                         'face 'mu4e-url-number-face)))
              (funcall next-url)))))))

  (add-hook 'mu4e-view-mode-hook 'mu4e-make-hypertext-clickable))
(after! forge
  (setq magit-status-sections-hook
        '(magit-insert-status-headers
          magit-insert-merge-log
          magit-insert-rebase-sequence
          magit-insert-am-sequence
          magit-insert-sequencer-sequence
          magit-insert-bisect-output
          magit-insert-bisect-rest
          magit-insert-bisect-log
          magit-insert-untracked-files
          magit-insert-unstaged-changes
          magit-insert-staged-changes
          magit-insert-stashes
          magit-insert-unpushed-to-pushremote
          magit-insert-unpushed-to-upstream-or-recent
          magit-insert-unpulled-from-pushremote
          magit-insert-unpulled-from-upstream
          forge-insert-requested-reviews
          ;; assigned
          forge-insert-assigned-pullreqs
          forge-insert-assigned-issues
          ;; pullreqs
          forge-insert-authored-pullreqs
          forge-insert-pullreqs
          ;; issues
          forge-insert-authored-issues
          forge-insert-issues)))

(after! notmuch
  ;; Don't copy into sent for me, server does it
  (setq notmuch-fcc-dirs nil)
  ;; Show newest at top by default
  (setq notmuch-search-oldest-first nil)
  ;; don't keep random message buffers around
  (setq message-kill-buffer-on-exit t)
  (setq message-bogus-addresses
        '("noreply.?[^g]?" "nospam" "invalid" "@.*@" "[^[:ascii:]].*@" "[ \t]"))
  (setq notmuch-poll-script "~/scripts/mail-sync-freq")
  ;; smtp mail setting; these are the same that `8
  (setq notmuch-archive-tags '("+archive" "-inbox"))
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
                               ("d" ("+deleted" "-inbox" "-unread") "Delete")
                               ("m" ("+killed" "-inbox" "-unread") "Mute/Kill thread")
                               ("k" ("+killed" "-inbox" "-unread") "Mute/Kill thread")
                               ))
  (defun my-notmuch-go-to-inbox ()
    (interactive)
    (notmuch-search "tag:inbox AND NOT tag:killed" nil))
  (defun my-notmuch-go-to-flagged ()
    (interactive)
    (notmuch-search "tag:flagged" nil))
  (defun my-notmuch-go-to-sent ()
    (interactive)
    (notmuch-search "tag:sent" nil))
  (map! :map 'notmuch-common-keymap
        :n "K" 'notmuch-tag-jump
        :n "gi" 'my-notmuch-go-to-inbox
        :n "gs" 'my-notmuch-go-to-flagged
        :n "gS" 'my-notmuch-go-to-sent)
  (map! :map 'notmuch-search-mode-map
        :n "e" 'notmuch-search-archive-thread
        ))
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "~/.dotfiles/email-stuff/send.py/send.py")
(setq message-sendmail-extra-arguments '("-f" "scogland1@llnl.gov" "--readfrommsg"))



(defun get-faces (pos)
  "Get the font faces at POS."
  (remq nil
        (list
         (get-char-property pos 'read-face-name)
         (get-char-property pos 'face)
         (plist-get (text-properties-at pos) 'face))))
