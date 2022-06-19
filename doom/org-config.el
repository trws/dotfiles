;;; ~/.dotfiles/doom/org-config.el -*- lexical-binding: t; -*-
(require 'dash)

(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/"))
;; (setq org-archive-location "~/onedrive/org/archive.org::* From %s" )
(setq org-archive-location "%s_archive::")

(setq org-archive-subtree-add-inherited-tags t)
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-scheduled-if-deadline-is-shown nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-agenda-skip-scheduled-delay-if-deadline 'post-deadline)


(with-eval-after-load "org"
  (add-to-list 'org-emphasis-alist '("`" org-code verbatim))
  ;; (require 'org-habit)
  ;; (add-to-list 'org-modules 'org-habit t)
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "PROJ(p)")
                (sequence "WAIT(w@/!)" "HOLD(h@/!)"  "IDEA(i@/!)""|" "KILL(k@/!)" "PHONE(P)" "MEETING(m)")))
        org-todo-keyword-faces '(("NEXT" . +org-todo-active)
                                 ("WAIT" . +org-todo-onhold)
                                 ("HOLD" . +org-todo-onhold)
                                 ("PROJ" . +org-todo-project)))
  (dolist (scheme '("message" "http" "https" "mailto" "news"))
    (org-link-set-parameters scheme
                             :follow
                             (lambda (url arg)
                               (browse-url (concat scheme ":" url) arg)))))

(setq +org-capture-notes-file (if (string= "chimera" (system-name))
                                  "inbox.org"
                                (concat (replace-regexp-in-string "\\..*" "" (system-name)) "-refile.org")))
(setq +org-capture-todo-file +org-capture-notes-file)

(defun strip-mail-heads (s)
  (->> s
       ( replace-regexp-in-string "^mu4e:msgid:" "" )
       (  replace-regexp-in-string "^message://%3c\\(.*\\)%3e" "\\1" )
       ( replace-regexp-in-string "^notmuch:id:" "")) )

(setq org-capture-templates
      '(("c" "Personal todo" entry
         (file+headline +org-capture-todo-file "Tasks")
         "* TODO %?\n%i\n%a" :prepend t)
        ("t" "Personal todo" entry
         (file+headline +org-capture-todo-file "Tasks")
         "* TODO %?\n%i\n" :prepend t)
        ("n" "Personal notes" entry
         (file+headline +org-capture-notes-file "Inbox")
         "* %u %?\n%i\n%a" :prepend t)
        ("j" "Journal" entry
         (file+olp+datetree +org-capture-journal-file)
         "* %U %?\n%i\n%a" :prepend t)
        ("p" "Templates for projects")
        ("pt" "Project-local todo" entry
         (file+headline +org-capture-project-todo-file "Inbox")
         "* TODO %?\n%i\n%a" :prepend t)
        ("pn" "Project-local notes" entry
         (file+headline +org-capture-project-notes-file "Inbox")
         "* %U %?\n%i\n%a" :prepend t)
        ("pc" "Project-local changelog" entry
         (file+headline +org-capture-project-changelog-file "Unreleased")
         "* %U %?\n%i\n%a" :prepend t)
        ("o" "Centralized templates for projects")
        ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
        ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
        ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
        ("M" "Mail capture" entry
         (file+headline +org-capture-notes-file "Inbox")
         "* TODO %:description      :mail:
Email with subject: %:annotation
[[message://%3c%(strip-mail-heads \"%:link\")%3e][MailMate]]
[[notmuch:id:%(strip-mail-heads \"%:link\")][notmuch]]
[[mu4e:msgid:%(strip-mail-heads \"%:link\")][mu4e]]

%i
")))


;; Ensure org buffers save themselves and I don't forget
;; (dolist (cmd '(org-refile org-archive org-archive-subtree org-todo org-schedule org-deadline))
;;   (advice-add cmd :after 'org-save-all-org-buffers))

(add-hook 'org-mode-hook 'my-org-mode-autosave-settings)
(defun my-org-mode-autosave-settings ()
  ;; (auto-save-mode 1)   ; this is unnecessary as it is on by default
  (set (make-local-variable 'auto-save-visited-file-name) t)
  (setq auto-save-interval 20)
  (auto-save-mode t))

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

;; Log timestamps into LOGBOOK drawer
(setq org-log-into-drawer t)



;;;;;;;;;; experimenting with this from norang
;;;;;;;;;;
;; (defun bh/find-project-task ()
;;   "Move point to the parent (project) task if any"
;;   (save-restriction
;;     (widen)
;;     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;       (while (org-up-heading-safe)
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq parent-task (point))))
;;       (goto-char parent-task)
;;       parent-task)))

;; ;; Sorting order for tasks on the agenda
;; (setq org-agenda-sorting-strategy
;;       (quote ((agenda habit-down time-up user-defined-up effort-up category-keep)
;;               (todo category-up effort-up)
;;               (tags category-up effort-up)
;;               (search category-up))))

;; ;; Enable display of the time grid so we can see the marker for the current time
;; (setq org-agenda-time-grid (quote ((daily today remove-match)
;;                                    #("----------------" 0 16 (org-heading t))
;;                                    (0900 1100 1300 1500 1700))))
;; (setq org-agenda-time-grid '((daily today require-timed)
;;                              (800 1000 1200 1400 1600 1800 2000)
;;                              "......" "----------------"))

;; ;; Display tags farther right
;; (setq org-agenda-tags-column -102)

;; ;;
;; ;; Agenda sorting functions
;; ;;
;; (setq org-agenda-cmp-user-defined 'bh/agenda-sort)

;; (defun bh/agenda-sort (a b)
;;   "Sorting strategy for agenda items.
;; Late deadlines first, then scheduled, then non-late deadlines"
;;   (let (result num-a num-b)
;;     (cond
;;                                         ; time specific items are already sorted first by org-agenda-sorting-strategy

;;                                         ; non-deadline and non-scheduled items next
;;      ((bh/agenda-sort-test 'bh/is-not-scheduled-or-deadline a b))

;;                                         ; deadlines for today next
;;      ((bh/agenda-sort-test 'bh/is-due-deadline a b))

;;                                         ; late deadlines next
;;      ((bh/agenda-sort-test-num 'bh/is-late-deadline '> a b))

;;                                         ; scheduled items for today next
;;      ((bh/agenda-sort-test 'bh/is-scheduled-today a b))

;;                                         ; late scheduled items next
;;      ((bh/agenda-sort-test-num 'bh/is-scheduled-late '> a b))

;;                                         ; pending deadlines last
;;      ((bh/agenda-sort-test-num 'bh/is-pending-deadline '< a b))

;;                                         ; finally default to unsorted
;;      (t (setq result nil)))
;;     result))

;; (defmacro bh/agenda-sort-test (fn a b)
;;   "Test for agenda sort"
;;   `(cond
;;                                         ; if both match leave them unsorted
;;     ((and (apply ,fn (list ,a))
;;           (apply ,fn (list ,b)))
;;      (setq result nil))
;;                                         ; if a matches put a first
;;     ((apply ,fn (list ,a))
;;      (setq result -1))
;;                                         ; otherwise if b matches put b first
;;     ((apply ,fn (list ,b))
;;      (setq result 1))
;;                                         ; if none match leave them unsorted
;;     (t nil)))

;; (defmacro bh/agenda-sort-test-num (fn compfn a b)
;;   `(cond
;;     ((apply ,fn (list ,a))
;;      (setq num-a (string-to-number (match-string 1 ,a)))
;;      (if (apply ,fn (list ,b))
;;          (progn
;;            (setq num-b (string-to-number (match-string 1 ,b)))
;;            (setq result (if (apply ,compfn (list num-a num-b))
;;                             -1
;;                           1)))
;;        (setq result -1)))
;;     ((apply ,fn (list ,b))
;;      (setq result 1))
;;     (t nil)))

;; (defun bh/is-not-scheduled-or-deadline (date-str)
;;   (and (not (bh/is-deadline date-str))
;;        (not (bh/is-scheduled date-str))))

;; (defun bh/is-due-deadline (date-str)
;;   (string-match "Deadline:" date-str))

;; (defun bh/is-late-deadline (date-str)
;;   (string-match "\\([0-9]*\\) d\. ago:" date-str))

;; (defun bh/is-pending-deadline (date-str)
;;   (string-match "In \\([^-]*\\)d\.:" date-str))

;; (defun bh/is-deadline (date-str)
;;   (or (bh/is-due-deadline date-str)
;;       (bh/is-late-deadline date-str)
;;       (bh/is-pending-deadline date-str)))

;; (defun bh/is-scheduled (date-str)
;;   (or (bh/is-scheduled-today date-str)
;;       (bh/is-scheduled-late date-str)))

;; (defun bh/is-scheduled-today (date-str)
;;   (string-match "Scheduled:" date-str))

;; (defun bh/is-scheduled-late (date-str)
;;   (string-match "Sched\.\\(.*\\)x:" date-str))
;; ;;;;;;;;; helper functions
;; (defun bh/is-project-p ()
;;   "Any task with a todo keyword subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task has-subtask))))

;; (defun bh/is-project-subtree-p ()
;;   "Any task with a todo keyword that is in a project subtree.
;; Callers of this function already widen the buffer view."
;;   (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
;;                               (point))))
;;     (save-excursion
;;       (bh/find-project-task)
;;       (if (equal (point) task)
;;           nil
;;         t))))

;; (defun bh/is-task-p ()
;;   "Any task with a todo keyword and no subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task (not has-subtask)))))

;; (defun bh/is-subproject-p ()
;;   "Any task which is a subtask of another project"
;;   (let ((is-subproject)
;;         (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;     (save-excursion
;;       (while (and (not is-subproject) (org-up-heading-safe))
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq is-subproject t))))
;;     (and is-a-task is-subproject)))

;; (defun bh/list-sublevels-for-projects-indented ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels 'indented)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)

;; (defun bh/list-sublevels-for-projects ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels t)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)

;; (defvar bh/hide-scheduled-and-waiting-next-tasks t)

;; (defun bh/toggle-next-task-display ()
;;   (interactive)
;;   (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
;;   (when  (equal major-mode 'org-agenda-mode)
;;     (org-agenda-redo))
;;   (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

;; (defun bh/skip-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 nil
;;               next-headline)) ; a stuck project, has subtasks but no next task
;;         nil))))

;; (defun bh/skip-non-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 next-headline
;;               nil)) ; a stuck project, has subtasks but no next task
;;         next-headline))))

;; (defun bh/skip-non-projects ()
;;   "Skip trees that are not projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (if (save-excursion (bh/skip-non-stuck-projects))
;;       (save-restriction
;;         (widen)
;;         (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;           (cond
;;            ((bh/is-project-p)
;;             nil)
;;            ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
;;             nil)
;;            (t
;;             subtree-end))))
;;     (save-excursion (org-end-of-subtree t))))

;; (defun bh/skip-non-tasks ()
;;   "Show non-project tasks.
;; Skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((bh/is-task-p)
;;         nil)
;;        (t
;;         next-headline)))))

;; (defun bh/skip-project-trees-and-habits ()
;;   "Skip trees that are projects"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ;; ((org-is-habit-p)
;;        ;;  subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-projects-and-habits-and-single-tasks ()
;;   "Skip trees that are projects, tasks that are habits, single non-project tasks"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ;; ((org-is-habit-p)
;;        ;;  next-headline)
;;        ((and bh/hide-scheduled-and-waiting-next-tasks
;;              (member "WAITING" (org-get-tags-at)))
;;         next-headline)
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
;;         next-headline)
;;        (t
;;         nil)))))

;; (defun bh/skip-project-tasks-maybe ()
;;   "Show tasks related to the current restriction.
;; When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
;; When not restricted, skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;            (limit-to-project (marker-buffer org-agenda-restrict-begin)))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ;; ((org-is-habit-p)
;;        ;;  subtree-end)
;;        ((and (not limit-to-project)
;;              (bh/is-project-subtree-p))
;;         subtree-end)
;;        ((and limit-to-project
;;              (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-project-tasks ()
;;   "Show non-project tasks.
;; Skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ;; ((org-is-habit-p)
;;        ;;  subtree-end)
;;        ((bh/is-project-subtree-p)
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-non-project-tasks ()
;;   "Show project tasks.
;; Skip project and sub-project tasks, habits, and loose non-project tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ;; ((org-is-habit-p)
;;        ;;  subtree-end)
;;        ((and (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        ((not (bh/is-project-subtree-p))
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-projects-and-habits ()
;;   "Skip trees that are projects and tasks that are habits"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ;; ((org-is-habit-p)
;;        ;;  subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-non-subprojects ()
;;   "Skip trees that are not projects"
;;   (let ((next-headline (save-excursion (outline-next-heading))))
;;     (if (bh/is-subproject-p)
;;         nil
;;       next-headline)))
;; ;;;;;;;;; block agenda
;; ;; Do not dim blocked tasks
;; (setq org-agenda-dim-blocked-tasks nil)

;; ;; Compact the block agenda view
;; (setq org-agenda-compact-blocks t)

;; ;; Custom agenda command definitions
;; (setq org-agenda-custom-commands
;;       (quote (("N" "Notes" tags "NOTE"
;;                ((org-agenda-overriding-header "Notes")
;;                 (org-tags-match-list-sublevels t)))
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""
;;                ((org-agenda-overriding-header "Habits")
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
;;               (" " "Agenda"
;;                ((agenda "" nil)
;;                 (tags "REFILE"
;;                       ((org-agenda-overriding-header "Tasks to Refile")
;;                        (org-tags-match-list-sublevels nil)))
;;                 (tags-todo "-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Stuck Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-stuck-projects)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-HOLD-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-projects)
;;                             (org-tags-match-list-sublevels 'indented)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED/!NEXT"
;;                            ((org-agenda-overriding-header (concat "Project Next Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
;;                             (org-tags-match-list-sublevels t)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(todo-state-down effort-up category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Project Subtasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Standalone Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED+WAITING|HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-tasks)
;;                             (org-tags-match-list-sublevels nil)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
;;                 (tags "-REFILE/"
;;                       ((org-agenda-overriding-header "Tasks to Archive")
;;                        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
;;                        (org-tags-match-list-sublevels nil))))
;;                nil))))
