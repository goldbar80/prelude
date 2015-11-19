;;; theme-goldbar.el --- theme related config

;;; Commentary:
;; none

;;; code:
;; theme
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes"))

(prelude-require-packages '(moe-theme))
(require 'moe-theme)
;;(load-theme 'moe-dark t)
;;(moe-theme-set-color 'magneta)

(if (window-system)
    (load-theme 'sanityinc-solarized-light)
  (load-theme 'moe-dark t)
  )

(setq moe-theme-mode-line-color 'orange)
(powerline-moe-theme)

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here
