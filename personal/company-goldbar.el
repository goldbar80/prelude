;;; company-goldbar.el -- company config

;;; Commentary:
;;

;;; Code:
(prelude-require-packages '(company-quickhelp))
(company-quickhelp-mode 1)

(setq company-idle-delay 0)
(define-key company-mode-map (kbd "C-\'") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(provide 'company-goldbar)
;;; company-goldbar.el ends here
