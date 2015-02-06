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

(provide 'misc-goldbar)
;;; misc-goldbar.el ends here
