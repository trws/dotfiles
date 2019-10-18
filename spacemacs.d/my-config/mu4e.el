;; example configuration for mu4e

;; make sure mu4e is in your load-path (require 'mu4e)

;; use mu4e for e-mail in emacs (setq mail-user-agent 'mu4e-user-agent)

;; Only needed if your maildir is _not_ ~/Maildir Must be a real dir, not a
;; symlink (setq mu4e-maildir "/Users/scogland1/Mail/scogland1")

;; these must start with a "/", and must exist (i.e.. /home/user/Maildir/sent
;; must exist) you use e.g. 'mu mkdir' to make the Maildirs if they don't
;; already exist

;; below are the defaults; if they do not exist yet, mu4e offers to create them.
;; they can also functions; see their docstrings. (setq mu4e-sent-folder
;; "/sent") (setq mu4e-drafts-folder "/drafts") (setq mu4e-trash-folder
;; "/trash") (setq mu4e-refile-folder "/archive")

;; smtp mail setting; these are the same that `gnus' uses.

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.office365.com"
      smtpmail-smtp-server "smtp.office365.com"
      smtpmail-local-domain "llnl.gov"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)

;; the maildirs you use frequently; access them with 'j' ('jump')
(setq
 mu4e-maildir-shortcuts '(("/archive" . ?a) ("/inbox" . ?i)
                          ("/work"        . ?w)
                          ("/sent"        . ?s)))

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "scogland1@llnl.gov"
      user-mail-address "scogland1@llnl.gov"
      user-full-name  "Tom Scogland")
(setq mu4e-attachment-dir "~/Downloads")
(setq mu4e-view-show-images t)
(setq mu4e-view-show-addresses t)

(setq mu4e-headers-fields
      '( (:date          .  25)    ;; alternatively, use :human-date
         (:flags         .   6)
         (:from          .  22)
         (:maildir       .  22)
         (:thread-subject       .  nil)))

(defun my/mu4e-inbox ()
  "jump to mu4e inbox"
  (interactive)
  (mu4e~headers-jump-to-maildir "/inbox"))

;; (evilified-state-evilify-map
;;   mu4e-headers-mode-map
;;   :mode mu4e-headers-mode
;;   :bindings
;;   (kbd "J") 'mu4e-headers-next
;;   (kbd "K") 'mu4e-headers-prev
;;   (kbd "y") 'mu4e-headers-mark-for-refile
;;   (kbd "#") 'mu4e-headers-mark-for-trash
;;   (kbd "X") 'mu4e-headers-mark-thread
;;   (kbd "G") 'my/mu4e-inbox
;;   )

;; (evilified-state-evilify-map
;;   mu4e-view-mode-map
;;   :mode mu4e-view-mode
;;   :bindings
;;   (kbd "J") 'mu4e-view-headers-next
;;   (kbd "K") 'mu4e-view-headers-prev
;;   )
