(prelude-require-packages '(meghanada))

;; (defun apm-meghanada-mode-setup ()
;;   "Setup meghanada-mode."
;;   (unless (f-exists? (meghanada--locate-server-jar))
;;     (meghanada-install-server)))

;; (use-package meghanada
;;   :ensure t
;;   :init (progn
;;           (gradle-mode 1)
;;           (add-hook 'meghanada-mode-hook #'apm-meghanada-mode-setup)
;;           (add-hook 'java-mode-hook 'meghanada-mode)
;;           (add-hook 'java-mode-hook (lambda() (setq c-basic-offset 2))))
;;   :config (progn
;;             (setq meghanada-use-company t
;;                   meghanada-use-flycheck t
;;                   meghanada-auto-start t)))

;; (use-package ensime
;;   :ensure t
;;   :init (progn (add-hook 'java-mode-hook 'ensime-mode)))
(provide 'java-goldbar)
