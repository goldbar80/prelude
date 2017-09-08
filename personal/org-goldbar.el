;;; org-goldbar.el -- org config

;;; Commentary:
;; none

;;; Code:

;; level faces
;; (custom-set-faces
;;  '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
;;  '(org-level-2 ((t (:inherit outline-2 :weight bold :height 1.3))))
;;  '(org-level-3 ((t (:inherit outline-3 :weight bold :height 1.3))))
;;  '(org-level-4 ((t (:inherit outline-4 :slant normal :weight bold :height 1.3))))
;;  '(org-level-5 ((t (:inherit outline-5 :weight bold :height 1.3))))
;;  )

;; fontify
(setq org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)

;; hide leading stars
(setq org-hide-leading-stars t)

;; inline source highlight
(setq org-src-fontify-natively t)

;; org-babel
                                        ; supported languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (python . t)
   (ruby . t)
   (dot . t)
   (ditaa . t)
   (perl . t)
   (latex . t)
   (groovy . t)
   (gnuplot . t)
   (sql . t)
   (org . t)
   (shell . t)
   (plantuml . t))
 )

                                        ; enable code execution during exporting
                                        ; to do the header processing only, use
                                        ; #+PROPERTY: header-args :eval never-export
                                        ; in the org file header
(setq org-export-babel-evaluate t)

;; ob-async
(require 'ob-async)
;;(add-to-list 'org-ctrl-c-ctrl-c-hook 'ob-async-org-babel-execute-src-block)
                                        ; window setup
(setq org-src-window-setup 'current-window)

;; org-sticky-header
(prelude-require-package 'org-sticky-header)
(use-package org-sticky-header
  :ensure t
  :config
  (org-sticky-header-mode))

;; org-bullets
(prelude-require-package 'org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; (setq org-bullets-bullet-list
;;       '(
;;       ;;; Large
;;         "◉"
;;         "●"
;;         "○"
;;         "◆"
;;         "◇"
;;       ;;; Small
;;         "►"
;;         "•"
;;         "★"
;;         "▸"
;;         ))

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

(progn
  (prelude-require-packages '(ox-reveal))
  (require 'ox-reveal)
  (setq org-reveal-root (concat "file://" (getenv "HOME") "/git/reveal.js"))
  (setq org-reveal-mathjax t)
  )

;; org-ioslide
(prelude-require-packages '(ox-ioslide))
(require 'ox-ioslide)
(require 'ox-ioslide-helper)

;; ox-confluence : confluence exporter
(prelude-require-packages '(org-plus-contrib))
(require 'ox-confluence)

;; add following whenever org-plus-contrib is updated
;;:menu-entry
;;'(?C "Export to Confluence Wiki"
;;     ((?R "To file" org-confluence-export-as-confluence)))

;; agenda setting
(require 'org-habit)
(setq org-agenda-files (quote ("~/Dropbox/agenda")))


(defun custom-org-agenda-mode-defaults ()
  (org-defkey org-agenda-mode-map "q" 'bury-buffer)
  (org-defkey org-agenda-mode-map "i" 'org-agenda-clock-in)
  (org-defkey org-agenda-mode-map "o" 'org-agenda-clock-out))

(add-hook 'org-agenda-mode-hook 'custom-org-agenda-mode-defaults 'append)


;; always show time grid in agenda view
;; (setq org-agenda-time-grid '((daily today today)
;;                              #("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" 0 16 (org-heading t))
;;                              (800 1000 1200 1400 1600 1800 2000)))
;; (setq org-agenda-block-separator ?━)
;; done states are always shown green
(setq org-habit-show-done-always-green t)

;; org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/Dropbox/agenda/.refile.org")

;; toc-org
;;(prelude-require-packages '(toc-org))
;;(add-hook 'org-mode-hook 'toc-org-enable)

;; company setting
(defun goldbar/org-mode-hook-setup ()
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-ispell))

(add-hook 'org-mode-hook 'goldbar/org-mode-hook-setup)
;; ??
;;(setq org-agenda-span 1)

;; org link setup

;;;; ol-crucible
(defvar ol-crucible-url-prefix "http://ol-crucible.us.oracle.com/cru")
(org-link-set-parameters
 "ol-crucible"
 :follow (lambda (path) (browse-url (concat ol-crucible-url-prefix "/" path)))
 :export (lambda (path desc backend)
           (cond
            ((eq 'html backend)
             (format "<a href=\"%s/%s\">%s[ol-ira]</a>"
                     ol-crucible-url-prefix path (or desc path)))
            ((eq 'goldbar/confluence backend)
             (format "[%s/%s]" ol-crucible-url-prefix path))
            ))
 :face '(:foreground "red" :inherit)
 :help-echo "oracle labs jira link")

;;;; ol-jira
(defvar ol-jira-url-prefix "http://ol-jira.us.oracle.com/browse")
(org-link-set-parameters
 "ol-jira"
 :follow (lambda (path) (browse-url (concat ol-jira-url-prefix "/" path)))
 :export (lambda (path desc backend)
           (cond
            ((eq 'html backend)
             (format "<a href=\"%s/%s\">%s[ol-ira]</a>"
                     ol-jira-url-prefix path (or desc path)))
            ((eq 'goldbar/confluence backend)
             (format "{jira:%s}" path))
            ))
 :face '(:foreground "red" :inherit)
 :help-echo "oracle labs jira link")

;;;; jira (oracle)
(defvar jira-url-prefix "https://jira.oraclecorp.com/jira/browse")
(org-link-set-parameters
 "jira"
 :follow (lambda (path) (browse-url (concat jira-url-prefix "/" path)))
 :export (lambda (path desc backend)
           (cond
            ((eq 'html backend)
             (format "<a href=\"%s/%s\">%s[ol-ira]</a>"
                     jira-url-prefix path (or desc path)))
            ((eq 'goldbar/confluence backend)
             (format "[%s/%s]" jira-url-prefix path))
            ))
 :face '(:foreground "red" :inherit)
 :help-echo "oracle labs jira link")

;;;; wikipedia
(defvar wikipedia-url-prefix "https://en.wikipedia.org/wiki")
(org-link-set-parameters
 "wikipedia"
 :follow (lambda (path) (browse-url (concat wikipedia-url-prefix "/" path)))
 :export (lambda (path desc backend)
           (cond
            ((eq 'html backend)
             (format "<a href=\"%s/%s\">%s[wikipedia]</a>"
                     wikipedia-url-prefix path (or desc path)))))
 :face '(:foreground "blue" :inherit)
 :help-echo "wikipedia link")


;;;; magit: format "<git dir>@<branch>". <branch> is optional
(org-link-set-parameters
 "magit"
 :follow (lambda (path)
           (let* ((splited (split-string path "@" t nil))
                 (dir (nth 0 splited))
                 (branch (nth 1 splited))
                 )
             (magit-status-internal dir)
             (if (not (eq branch nil))
                 (magit-checkout branch))))
 :face '(:foreground "red" :inherit)
 :export (lambda (path desc backend)
           (let* ((splited (split-string path "@" t nil))
                  (dir (nth 0 splited))
                  (branch (nth 1 splited)))
             (format "%s" branch)
             )
           )
 )


;; screencapture
;; http://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it

(if (window-system)
    (progn
      (defun goldbar/org-screenshot (basename)
        "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
        (interactive
         (let ((default_name (format-time-string "%Y%m%d_%H%M%S")))
           (list
            (read-string (format "file name prefix (%s)): " default_name) nil nil default_name))))
        (message basename)
        (org-display-inline-images)
        (setq filename
              (concat
               (file-name-base (buffer-file-name))
               "/"
               basename
               ".png"))
        (unless (file-exists-p (file-name-directory filename))
          (make-directory (file-name-directory filename)))
                                        ; take screenshot
        (if (eq system-type 'darwin)
            (call-process "screencapture" nil nil nil "-i" filename))
        (if (eq system-type 'gnu/linux)
            (call-process "import" nil nil nil filename))
                                        ; insert into file if correctly taken
        (if (file-exists-p filename)
            (insert (concat "[[file:" filename "]]"))))
      (add-hook 'org-mode-hook
                (lambda ()
                  (local-set-key (kbd "C-c q" ) 'goldbar/org-screenshot)))
      ))



(provide 'org-goldbar)
;;; org-goldbar.el ends here
