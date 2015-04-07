;;; latex-goldbar.el --- latex config

;;; Commentary:
;; none

;;; Code:

;; latexmk
(prelude-require-packages '(auctex-latexmk))
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


(provide 'latex-goldbar)
;;; latex-goldbar.el ends here
