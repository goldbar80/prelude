;; from http://tuhdo.github.io/c-ide.html

(prelude-require-package 'groovy-mode)
(require 'groovy-mode)
(setq groovy-home "/usr/local")
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-hook 'groovy-mode-hook (lambda() (setq c-basic-offset 2)))

(provide 'groovy-goldbar)
;;; cpp-goldbar.el ends here
