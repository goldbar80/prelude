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

;; coding system
(setq-default buffer-file-coding-system 'utf-8)

;; no menubar
(menu-bar-mode -1)

;; no scrollbar
(scroll-bar-mode -1)

;; old style fullscreen
(setq ns-use-native-fullscreen nil)

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

;; window split vertical <==> horizontal
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-c |") 'toggle-window-split)

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
    (set-fontset-font fontset 'unicode (font-spec :family "Source Code Pro for Powerline" :weight 'light :registry "unicode-bmp"))
    (set-fontset-font fontset 'latin
                      (font-spec :family "Source Code Pro for Powerline" :weight 'light :registry "unicode-bmp"))
    (set-fontset-font fontset 'hangul
                      '("NanumGothicCoding" . "unicode-bmp"))
;    (set-face-font 'default "Inconsolata-10")
    (set-face-attribute 'default nil
                        :font fontset
                        :height 140))))

(provide 'misc-goldbar)
;;; misc-goldbar.el ends here
