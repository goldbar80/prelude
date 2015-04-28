;;; latex-goldbar.el --- latex config

;;; Commentary:
;; none

;;; Code:

;; latexmk
(prelude-require-packages '(auctex-latexmk))
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; use skim as viewer
(when (eq system-type 'darwin)
  (setq TeX-view-program-selection
        '((output-dvi "DVI Viewer")
          (output-pdf "PDF Viewer")
          (output-html "HTML Viewer")))

  (setq TeX-view-program-list
        '(("DVI Viewer" "open -a Skim %o")
          ("PDF Viewer" "open -a Skim %o")
          ("HTML Viewer" "open %o"))))

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


(provide 'latex-goldbar)
;;; latex-goldbar.el ends here
