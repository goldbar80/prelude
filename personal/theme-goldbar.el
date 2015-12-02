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
    (load-theme 'base16-flat-dark)
  (load-theme 'moe-dark t)
  )

;; powerline
(setq moe-theme-mode-line-color 'blue)
(powerline-moe-theme)

(prelude-require-packages '(spaceline eyebrowse persp-mode window-numbering anzu))

;; date format
(setq display-time-string-forms '((format
                                   "%s/%s(%s) %s:%s" month day dayname 24-hours minutes)))

(display-time-mode t)

(powerline-reset)
(require 'spaceline-config)
(setq powerline-default-separator 'wave)
(eyebrowse-mode 1)
(window-numbering-mode 1)
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
(setq spaceline-minor-modes-p nil)
(spaceline-spacemacs-theme)

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here
