;;; theme-goldbar.el --- theme related config

;;; Commentary:
;; none

;;; code:
;; theme
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes"))

(prelude-require-packages '(moe-theme solarized-theme dracula-theme doom-themes neotree spacemacs-theme))

(load-theme 'spacemacs-light)

;;(setq solarized-high-contrast-mode-line nil)
(setq ns-use-srgb-colorspace nil)

;; powerline
;; (setq moe-theme-mode-line-color 'yellow)
;; (powerline-moe-theme)

(prelude-require-packages '(powerline spaceline eyebrowse persp-mode window-numbering anzu all-the-icons))
(require 'all-the-icons)

;; date format
(setq display-time-string-forms '((format
                                   "%s/%s(%s) %s:%s" month day dayname 24-hours minutes)))

(display-time-mode t)

;;(powerline-reset)
(require 'spaceline-config)
(setq powerline-default-separator 'slant)
(setq powerline-height 21)
(eyebrowse-mode 1)
(window-numbering-mode 1)
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
(setq spaceline-minor-modes-p nil)
(setq spaceline-version-control-p t)
(setq anzu-cons-mode-line-p nil)
;; fancy git icon
(defadvice vc-mode-line (after strip-backend () activate)
  (when (stringp vc-mode)
    (let ((gitlogo (replace-regexp-in-string "^ Git." "  " vc-mode)))
      (setq vc-mode gitlogo))))

(spaceline-spacemacs-theme)
(spaceline-helm-mode)
(spaceline-info-mode)

;; major mode icons
(prelude-require-package 'mode-icons)
(mode-icons-mode)

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here



(message (vc-mode-line (buffer-file-name)))
