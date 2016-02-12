;;; package --- hello

(prelude-require-packages '(scala-mode2 ensime))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'scala-goldbar)
