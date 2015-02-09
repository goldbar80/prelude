;;; misc-goldbar.el --- config that is not related to a specific package

;;; Commentary:

;; none

;;; Code:

;; reload emacs
(defun reload-emacs ()
  (interactive)
  "reload emacs configuration"
  (load-file (concat prelude-dir "init.el"))
  )

;; no menubar
(menu-bar-mode -1)

;; no scrollbar
(scroll-bar-mode -1)

;; whitespace witdh
(setq whitespace-line-column 120)

;; OSX
(when (eq system-type 'darwin)
                                        ; fullscreen
  (defun goldbar/fullscreen ()
    "Toggle full screen"
    (interactive)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
  (global-set-key (kbd "C-c C-f") 'goldbar/fullscreen)
                                        ; option key as meta
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))

;; paradox package interface
(prelude-require-packages '(paradox))


(provide 'misc-goldbar)
;;; misc-goldbar.el ends here
