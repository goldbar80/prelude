;; Choose either listings or minted for exporting source code blocks.
;; Using minted (as here) requires pygments be installed. To use the
;; default listings package instead, use
;; (setq org-latex-listings t)
;; and change references to "minted" below to "listings"
(setq org-latex-listings 'minted)

;; default settings for minted code blocks.
;; bg will need to be defined in the preamble of your document. It's defined in  org-preamble-xelatex.sty below.
(setq org-latex-minted-options
      '(;("frame" "single")
        ("bgcolor" "bg")
        ("fontsize" "\\small")
        ))

;; turn off the default toc behavior; deal with it properly in headers to files.
(defun org-latex-no-toc (depth)
  (when depth
    (format "%% Org-mode is exporting headings to %s levels.\n"
            depth)))
(setq org-latex-format-toc-function 'org-latex-no-toc)

;; note the insertion of the \input statement for the vc information
(add-to-list 'org-latex-classes
             '("memarticle"
               ;;"\\documentclass[10pt,oneside,article]{memoir}\n\\input{vc} % vc package"
               "\\documentclass[11pt,oneside,article]{memoir}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("mambo"
               ;;"\\documentclass[10pt,oneside]{memoir}\n\\input{vc} % vc package"
               "\\documentclass[11pt,oneside]{memoir}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;; LaTeX compilation command. For orgmode docs we just always use xelatex for convenience.
;; You can change it to pdflatex if you like, just remember to make the adjustments to the packages-alist below.
(setq org-latex-pdf-process '("latexmk -pdflatex='xelatex -synctex=1 --shell-escape' -pdf %f"))

;; Default packages included in the tex file. As before, org-preamble-xelatex is part of latex-custom-kjh.
;; There's org-preamble-pdflatex as well, if you wish to use that instead.
(setq org-latex-default-packages-alist nil)
(setq org-latex-packages-alist
      '(("minted" "org-preamble-xelatex" t)
        ("" "graphicx" t)
        ("" "longtable" nil)
        ("" "fullpage" t)
        ("" "float" )))

(provide 'org-export-goldbar)
