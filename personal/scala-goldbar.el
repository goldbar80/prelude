;;; package --- hello

(prelude-require-packages '(scala-mode2 ensime))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; for rscala
(setenv "rscala_dir" "/usr/local/lib/R/3.2/site-library/rscala/java")
(setenv "rscala_name" "rscala_2.11-1.0.9")

(provide 'scala-goldbar)