;;; powerline-goldbar.el --- powerline setting-constant

;;; Commentary:
;; none

;;; Code:

(prelude-require-package 'powerline)

(custom-set-faces
 '(mode-line ((t (:box nil :height 110 :weight light))))
 '(mode-line-inactive ((t (:box nil :height 90 :weight light)))))

;; for solarized-light
;; (defface powerline-active1-g '((t (:background "#ada96e" :inherit mode-line)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-active2-g '((t (:background "#ede275" :inherit mode-line)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; (defface powerline-inactive1-g
;;   '((t (:background "#887755" :inherit mode-line-inactive)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-inactive2-g
;;   '((t (:background "#bbaa55" :inherit mode-line-inactive)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; for tomorrow-night
;; (defface powerline-active1-g '((t (:background "#585a5e" :inherit mode-line)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-active2-g '((t (:background "#4a8e87" :inherit mode-line)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; (defface powerline-inactive1-g
;;   '((t (:background "#282a2e" :inherit mode-line-inactive)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-inactive2-g
;;   '((t (:background "#373b41" :inherit mode-line-inactive)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; for twilight-bright
;; (defface powerline-active1-g '((t (:background "#c9d6df" :inherit mode-line)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-active2-g '((t (:background "#99a6af" :inherit mode-line)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; (defface powerline-inactive1-g
;;   '((t (:background "#cecece" :inherit mode-line-inactive)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-inactive2-g
;;   '((t (:background "#9e9e9e" :inherit mode-line-inactive)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; for twilight-anti-bright

(if (window-system)
    (progn
      (defface powerline-active1-g '((t (:foreground "#8eafd9" :background "#3b535e" :inherit mode-line)))
        "Powerline face 1."
        :group 'powerline)

      (defface powerline-active2-g '((t (:foreground "#aecff9" :background "#6b838e" :inherit mode-line)))
        "Powerline face 2."
        :group 'powerline)

      (defface powerline-inactive1-g
        '((t (:foreground "#567e9a" :background "#3f4750" :inherit mode-line-inactive)))
        "Powerline face 1."
        :group 'powerline)

      (defface powerline-inactive2-g
        '((t (:foreground "#769eba" :background "#6f7780" :inherit mode-line-inactive)))
        "Powerline face 2."
        :group 'powerline))
  (progn
    (defface powerline-active1-g '((t (:foreground "black" :background "white" :inherit mode-line)))
      "Powerline face 1."
      :group 'powerline)

    (defface powerline-active2-g '((t (:foreground "white" :background "black" :inherit mode-line)))
      "Powerline face 2."
      :group 'powerline)

    (defface powerline-inactive1-g
      '((t (:foreground "black" :background "DimGray" :inherit mode-line-inactive)))
      "Powerline face 1."
      :group 'powerline)

    (defface powerline-inactive2-g
      '((t (:foreground "DimGray" :background "black" :inherit mode-line-inactive)))
      "Powerline face 2."
      :group 'powerline))
  )

;; for base16-mocha

;; (defface powerline-active1-g '((t (:foreground "#d8cfcd" :background "#847260" :inherit mode-line)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-active2-g '((t (:foreground "#f8efed" :background "#a49280" :inherit mode-line)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; (defface powerline-inactive1-g
;;   '((t (:foreground "#8e806a" :background "#635646" :inherit mode-line-inactive)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-inactive2-g
;;   '((t (:foreground "#9e907a" :background "#736656" :inherit mode-line-inactive)))
;;   "Powerline face 2."
;;   :group 'powerline)


;; for base16-ocean

;; (defface powerline-active1-g '((t (:foreground "#d0d5de" :background "#3b404b" :inherit mode-line)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-active2-g '((t (:foreground "#e0e5ee" :background "#4b505b" :inherit mode-line)))
;;   "Powerline face 2."
;;   :group 'powerline)

;; (defface powerline-inactive1-g
;;   '((t (:foreground "#4f5b66" :background "#2b303b" :inherit mode-line-inactive)))
;;   "Powerline face 1."
;;   :group 'powerline)

;; (defface powerline-inactive2-g
;;   '((t (:foreground "#4f5b66" :background "#2b303b" :inherit mode-line-inactive)))
;;   "Powerline face 2."
;;   :group 'powerline)

(require 'powerline)




(setq-default mode-line-format
              '("%e"
                (:eval
                 (let* ((active (powerline-selected-window-active))
                        (face1 (if active 'powerline-active1-g
                                 'powerline-inactive1-g))
                        (face2 (if active 'powerline-active2-g
                                 'powerline-inactive2-g))
                        (lhs (list
                              (powerline-raw "%*" nil 'l)
                              ;;                              (powerline-raw (wg-mode-line-string) nil 'l)
                              (powerline-buffer-size nil 'l)
                              (powerline-buffer-id nil 'l)

                              (powerline-raw " ")
                              (powerline-arrow-right nil face1)

                              (when (boundp 'erc-modified-channels-object)
                                (powerline-raw erc-modified-channels-object
                                               face1 'l))

                              (powerline-major-mode face1 'l)
                              (powerline-process face1)
                              (powerline-minor-modes face1 'l)
                              (powerline-narrow face1 'l)

                              (powerline-raw " " face1)
                              (powerline-arrow-right face1 face2)

                              (powerline-vc face2)))
                        (rhs (list
                              (powerline-raw global-mode-string face2 'r)

                              (powerline-arrow-left face2 face1)

                              (powerline-raw "%4l" face1 'r)
                              (powerline-raw ":" face1)
                              (powerline-raw "%3c" face1 'r)

                              (powerline-arrow-left face1 nil)
                              (powerline-raw " ")
                              (powerline-raw "%6p" nil 'r)

                              (powerline-hud face2 face1))))
                   (concat
                    (powerline-render lhs)
                    (powerline-fill face2 (powerline-width rhs))
                    (powerline-render rhs))))))

(setq display-time-string-forms '((format
                                   "%s/%s(%s) %s:%s" month day dayname 24-hours minutes)))

(display-time-mode t)

(provide 'powerline-goldbar)
;;; powerline-goldbar.el ends here
