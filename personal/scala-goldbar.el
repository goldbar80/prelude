;;; package --- hello

(prelude-require-packages '(scala-mode))

(use-package ensime
  :ensure t
  :init (progn
          (add-hook 'scala-mode-hook 'ensime-mode))
  :config (progn
            (setq ensime-startup-snapshot-notification nil)
            (add-to-list 'auto-mode-alist '("\\.sc" . scala-mode))))


;; for rscala
(setenv "rscala_dir" "/usr/local/lib/R/3.2/site-library/rscala/java")
(setenv "rscala_name" "rscala_2.11-1.0.9")

(provide 'scala-goldbar)
