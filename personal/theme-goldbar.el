;;; theme-goldbar.el --- theme related config

;;; Commentary:
;; none

;;; code:
;; theme
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes"))

(if (window-system)
    (load-theme 'base16-flat-dark t)
  )

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here
