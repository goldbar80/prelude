;;; org-goldbar.el -- org config

;;; Commentary:
;; none

;;; Code:

;; level faces
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold :height 1.3))))
 '(org-level-3 ((t (:inherit outline-3 :weight bold :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :slant normal :weight bold :height 1.3))))
 '(org-level-5 ((t (:inherit outline-5 :weight bold :height 1.3))))
 )

;; hide leading stars
(setq org-hide-leading-stars t)

;; inline source highlight
(setq org-src-fontify-natively t)

;; org-babel
                                        ; supported languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (ruby . t)
   (dot . t)
   (ditaa . t)
   (perl . t)
   (latex . t)
   (groovy . t)
   (gnuplot . t))
 )

                                        ; window setup
(setq org-src-window-setup 'current-window)

;; org-bullets
(prelude-require-package 'org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-bullets-bullet-list
      '(
      ;;; Large
        "◉"
        "●"
        "○"
        "◆"
        "◇"
      ;;; Small
        "►"
        "•"
        "★"
        "▸"
        ))

;; org-present
(prelude-require-packages '(org-present))

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

;; org-reveal
(prelude-require-packages '(ox-reveal))
(require 'ox-reveal)
(setq org-reveal-root (concat "file://" (getenv "HOME") "/git/reveal.js"))
(setq org-reveal-mathjax t)

;; ox-confluence : confluence exporter
(prelude-require-packages '(org-plus-contrib))
(require 'ox-confluence)

;; add following whenever org-plus-contrib is updated
;;:menu-entry
;;'(?C "Export to Confluence Wiki"
;;     ((?R "To file" org-confluence-export-as-confluence)))

;; agenda setting
(require 'org-habit)
(require 'org-helpers)
                                        ;agenda Dir
(setq org-agenda-files (quote ("~/git/agenda")))

                                        ;todo keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(o)" "|" "CANCELLED(c@/!)")))
                                        ;agenda custom command

(setq org-agenda-window-setup 'current-window)

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))


;; ("r" "Tasks to Refile" alltodo ""
;;  ((org-agenda-overriding-header "Tasks to Refile")
;;   (org-agenda-files (quote ("~/.refile.org")))))


;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)


;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (alltodo ""
                         ((org-agenda-overriding-header "Tasks to Refile")
                          (org-agenda-files '("~/.refile.org"))
                          (org-agenda-skip-function
                           '(oh/agenda-skip :headline-if-restricted-and '(todo)))))
                ;; (tags "REFILE"
                ;;       ((org-agenda-overriding-header "Tasks to Refile")
                ;;        (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING|HOLD/!"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                ;; (tags "-REFILE/"
                ;;       ((org-agenda-overriding-header "Tasks to Archive")
                ;;        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                ;;        (org-tags-match-list-sublevels nil)))
                )
               nil))))

;;;; helper functions
(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defvar bh/hide-scheduled-and-waiting-next-tasks t)

(defun bh/toggle-next-task-display ()
  (interactive)
  (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((bh/is-project-p)
            nil)
           ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-non-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-task-p)
        nil)
       (t
        next-headline)))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((and bh/hide-scheduled-and-waiting-next-tasks
             (member "WAITING" (org-get-tags-at)))
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-project-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       ((bh/is-project-subtree-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-project-tasks ()
  "Show project tasks.
Skip project and sub-project tasks, habits, and loose non-project tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       ((not (bh/is-project-subtree-p))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

;; Custom agenda command definitions
;; (setq org-agenda-custom-commands
;;       '(("a" "Agenda"
;;        ((agenda "" nil)
;;           (alltodo ""
;;                    ((org-agenda-overriding-header "Tasks to Refile")
;;                     (org-agenda-files '("~/.refile.org"))
;;                     (org-agenda-skip-function
;;                      '(oh/agenda-skip :headline-if-restricted-and '(todo)))))
;;           (tags-todo "-CANCELLED/!-HOLD-WAITING"
;;                      ((org-agenda-overriding-header "Stuck Projects")
;;                       (org-agenda-skip-function
;;                        '(oh/agenda-skip :subtree-if '(inactive non-project non-stuck-project habit scheduled deadline)))))
;;           (tags-todo "-WAITING-CANCELLED/!NEXT"
;;                      ((org-agenda-overriding-header "Next Tasks")
;;                       (org-agenda-skip-function
;;                        '(oh/agenda-skip :subtree-if '(inactive project habit scheduled deadline)))
;;                       (org-tags-match-list-sublevels t)
;;                       (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep))))
;;           (tags-todo "-CANCELLED/!-NEXT-HOLD-WAITING"
;;                      ((org-agenda-overriding-header "Available Tasks")
;;                       (org-agenda-skip-function
;;                        '(oh/agenda-skip :headline-if '(project)
;;                                         :subtree-if '(inactive habit scheduled deadline)
;;                                         :subtree-if-unrestricted-and '(subtask)
;;                                         :subtree-if-restricted-and '(single-task)))
;;                       (org-agenda-sorting-strategy '(category-keep))))
;;           (tags-todo "-CANCELLED/!"
;;                      ((org-agenda-overriding-header "Currently Active Projects")
;;                       (org-agenda-skip-function
;;                        '(oh/agenda-skip :subtree-if '(non-project stuck-project inactive habit)
;;                                         :headline-if-unrestricted-and '(subproject)
;;                                         :headline-if-restricted-and '(top-project)))
;;                       (org-agenda-sorting-strategy '(category-keep))))
;;           (tags-todo "-CANCELLED/!WAITING|HOLD"
;;                      ((org-agenda-overriding-header "Waiting and Postponed Tasks")
;;                       (org-agenda-skip-function
;;                        '(oh/agenda-skip :subtree-if '(project habit))))))
;;          nil)
;;         ("r" "Tasks to Refile" alltodo ""
;;          ((org-agenda-overriding-header "Tasks to Refile")
;;           (org-agenda-files '("~/.refile.org"))))
;;         ("#" "Stuck Projects" tags-todo "-CANCELLED/!-HOLD-WAITING"
;;          ((org-agenda-overriding-header "Stuck Projects")
;;           (org-agenda-skip-function
;;            '(oh/agenda-skip :subtree-if '(inactive non-project non-stuck-project
;;                                           habit scheduled deadline)))))
;;         ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
;;          ((org-agenda-overriding-header "Next Tasks")
;;           (org-agenda-skip-function
;;            '(oh/agenda-skip :subtree-if '(inactive project habit scheduled deadline)))
;;           (org-tags-match-list-sublevels t)
;;           (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep))))
;;         ("R" "Tasks" tags-todo "-CANCELLED/!-NEXT-HOLD-WAITING"
;;          ((org-agenda-overriding-header "Available Tasks")
;;           (org-agenda-skip-function
;;            '(oh/agenda-skip :headline-if '(project)
;;                             :subtree-if '(inactive habit scheduled deadline)
;;                             :subtree-if-unrestricted-and '(subtask)
;;                             :subtree-if-restricted-and '(single-task)))
;;           (org-agenda-sorting-strategy '(category-keep))))
;;         ("p" "Projects" tags-todo "-CANCELLED/!"
;;          ((org-agenda-overriding-header "Currently Active Projects")
;;           (org-agenda-skip-function
;;            '(oh/agenda-skip :subtree-if '(non-project inactive habit)))
;;               (org-agenda-sorting-strategy '(category-keep))
;;               (org-tags-match-list-sublevels 'indented)))
;;         ("w" "Waiting Tasks" tags-todo "-CANCELLED/!WAITING|HOLD"
;;          ((org-agenda-overriding-header "Waiting and Postponed Tasks")
;;           (org-agenda-skip-function '(oh/agenda-skip :subtree-if '(project habit)))))))


;; org-pomodoro
(prelude-require-packages '(org-pomodoro))
(require 'org-pomodoro)
(setq org-pomodoro-keep-killed-pomodoro-time t)
                                        ; shortcut
(global-set-key (kbd "C-c C-x C-i") 'org-pomodoro)
(global-set-key (kbd "C-c C-x C-o") 'org-pomodoro)
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-x C-i") 'org-pomodoro)
            (local-set-key (kbd "C-c C-x C-o") 'org-pomodoro))
          'append)
                                        ; agenda shortcut
                                        ; Needs terminal-notifier (brew install terminal-notifier)
(defun notify-osx (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-message" message))

                                        ; org-pomodoro mode hooks
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (notify-osx "Pomodoro completed!" "Time for a break.")))

(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Short Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-long-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Long Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (notify-osx "Pomodoro Killed" "One does not simply kill a pomodoro!")))


(defun custom-org-agenda-mode-defaults ()
  (org-defkey org-agenda-mode-map "W" 'oh/agenda-remove-restriction)
  (org-defkey org-agenda-mode-map "N" 'oh/agenda-restrict-to-subtree)
  (org-defkey org-agenda-mode-map "P" 'oh/agenda-restrict-to-project)
  (org-defkey org-agenda-mode-map "q" 'bury-buffer)
  (org-defkey org-agenda-mode-map "I" 'org-pomodoro)
  (org-defkey org-agenda-mode-map "O" 'org-pomodoro)
  (org-defkey org-agenda-mode-map "i" 'org-agenda-clock-in)
  (org-defkey org-agenda-mode-map "o" 'org-agenda-clock-out)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-o") 'org-pomodoro))

(add-hook 'org-agenda-mode-hook 'custom-org-agenda-mode-defaults 'append)


;; always show time grid in agenda view
(setq org-agenda-time-grid '((daily today today)
                             #("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" 0 16 (org-heading t))
                             (800 1000 1200 1400 1600 1800 2000)))
(setq org-agenda-block-separator ?━)
;; done states are always shown green
(setq org-habit-show-done-always-green t)

;; org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/.refile.org")

;;;; capture template
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/.refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/.refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/.refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/.refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("h" "Habit" entry (file "~/.refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; refile
                                        ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

                                        ; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

                                        ; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

                                        ; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

                                        ; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
                                        ; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
                                        ; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
                                        ; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets."
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;; toc-org
(prelude-require-packages '(toc-org))
(add-hook 'org-mode-hook 'toc-org-enable)

;; company setting
(defun goldbar/org-mode-hook-setup ()
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-ispell))

(add-hook 'org-mode-hook 'goldbar/org-mode-hook-setup)
;; ??
(setq org-agenda-span 1)
(provide 'org-goldbar)
;;; org-goldbar.el ends here
