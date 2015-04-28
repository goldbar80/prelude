;;; eclim-goldbar.el --- eclim config

;;; Commentary:
;; none

;;; Code:

(prelude-require-packages '(emacs-eclim))

(require 'company)
(require 'company-emacs-eclim)
;;(company-emacs-eclim-setup)
(global-company-mode t)
(global-eclim-mode)

(provide 'eclim-goldbar)
;;; eclim-goldbar.el ends here
