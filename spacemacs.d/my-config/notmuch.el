;; (evil-set-initial-state 'notmuch-search-mode 'normal)
;; (evil-set-initial-state 'notmuch-tree-mode 'normal)
;; (evil-set-initial-state 'notmuch-hello-mode 'normal)






(add-hook 'notmuch-search-hook #'evil-normalize-keymaps)
