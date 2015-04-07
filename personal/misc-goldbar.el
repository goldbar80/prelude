;;; misc-goldbar.el --- config that is not related to a specific package

;;; Commentary:

;; none

;;; Code:

;; reload emacs
(defun reload-emacs ()
  (interactive)
  "reload emacs configuration"
  (load-file (concat prelude-dir "init.el"))
  )

;; no menubar
(menu-bar-mode -1)

;; no scrollbar
(scroll-bar-mode -1)

;; whitespace witdh
(setq whitespace-line-column 120)

;; fullscreen
(defun goldbar/fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(global-set-key (kbd "C-c C-f") 'goldbar/fullscreen)

;; OSX
(when (eq system-type 'darwin)
                                        ; option key as meta
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)
                                        ; increase font size For OSX
  (set-face-attribute 'default nil :font "fontset-default" :height 130))

;; paradox package interface
(prelude-require-packages '(paradox))

;; korean font
(prelude-require-packages '(list-utils font-utils))

(cond
 ((eq window-system nil) nil)
 ((font-utils-exists-p "Source Code Pro")
  (let ((fontset "fontset-default"))
    (set-fontset-font fontset 'latin
                      (font-spec :family "Source Code Pro" :weight 'normal :registry "unicode-bmp"))
    (set-fontset-font fontset 'hangul
                      '("NanumGothicCoding" . "unicode-bmp"))
    (set-face-attribute 'default nil
                        :font fontset
                        :height 110))))

(provide 'misc-goldbar)
;;; misc-goldbar.el ends here
