;;; helm-goldbar.el -- helm config

;;; Commentary:
;; none

;;; Code:

(require 'helm)

;; helm-find-files
                                        ; when selection is directory, keep searching.
                                        ; http://emacs.stackexchange.com/questions/3798/how-do-i-make-pressing-ret-in-helm-find-files-open-the-directory/7896#7896
(defun goldbar/helm-find-files-navigate-forward (orig-fun &rest args)
  (if (file-directory-p (helm-get-selection))
      (apply orig-fun args)
    (helm-maybe-exit-minibuffer)))
(advice-add 'helm-execute-persistent-action :around #'goldbar/helm-find-files-navigate-forward)
(define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)

                                        ; backspace goes 1 level up
                                        ; http://emacs.stackexchange.com/questions/3798/how-do-i-make-pressing-ret-in-helm-find-files-open-the-directory/7896#7896
(defun goldbar/helm-find-files-navigate-back (orig-fun &rest args)
  (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
      (helm-find-files-up-one-level 1)
    (apply orig-fun args)))
(advice-add 'helm-ff-delete-char-backward :around #'goldbar/helm-find-files-navigate-back)

;; helm-M-x
(setq helm-M-x-fuzzy-match t)

;; helm-google
(prelude-require-packages '(helm-google))

(provide 'helm-goldbar)
;;; heml-goldbar.el ends here
