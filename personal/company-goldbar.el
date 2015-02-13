;;; company-goldbar.el -- company config

;;; Commentary:
;;

;;; Code:
(prelude-require-packages '(company-quickhelp))
(company-quickhelp-mode 1)

(define-key company-active-map (kbd "C-.") 'company-complete)

(provide 'company-goldbar)
;;; company-goldbar.el ends here
