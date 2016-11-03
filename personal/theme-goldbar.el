;;; theme-goldbar.el --- theme related config

;;; Commentary:
;; none

;;; code:
;; theme
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes"))

(prelude-require-packages '(moe-theme solarized-theme dracula-theme doom-themes neotree spacemacs-theme))

(if (window-system)
    (progn
      ;; (load-theme 'doom-one)
      ;; ;;; OPTIONAL
      ;; ;; brighter source buffers
      ;; (add-hook 'find-file-hook 'doom-buffer-mode)
      ;; ;; brighter minibuffer when active
      ;; (add-hook 'minibuffer-setup-hook 'doom-brighten-minibuffer)
      ;; ;; Custom neotree theme
      ;; (require 'doom-neotree)
      ;; (setq doom-neotree-enable-file-icons t)
      (load-theme 'spacemacs-dark)
      )
  (load-theme 'moe-dark t)
  )
;;(setq solarized-high-contrast-mode-line nil)
(setq ns-use-srgb-colorspace nil)

;; powerline
;; (setq moe-theme-mode-line-color 'yellow)
;; (powerline-moe-theme)

(prelude-require-packages '(powerline spaceline eyebrowse persp-mode window-numbering anzu))

;; date format
(setq display-time-string-forms '((format
                                   "%s/%s(%s) %s:%s" month day dayname 24-hours minutes)))

(display-time-mode t)

;;(powerline-reset)
(require 'spaceline-config)
(setq powerline-default-separator 'rounded)
(setq powerline-height 21)
(eyebrowse-mode 1)
(window-numbering-mode 1)
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
(setq spaceline-minor-modes-p nil)
(setq anzu-cons-mode-line-p nil)
(spaceline-spacemacs-theme)

;; major mode icons
(prelude-require-package 'mode-icons)
(mode-icons-mode)

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here
