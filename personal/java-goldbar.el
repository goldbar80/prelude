(prelude-require-packages '(ensime))

(require 'ensime)
(add-hook 'java-mode-hook 'ensime-mode)
(add-hook 'java-mode-hook (lambda() (setq c-basic-offset 2)))

(provide 'java-goldbar)
