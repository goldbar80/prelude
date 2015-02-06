;;; org-goldbar.el -- org config

;;; Commentary:
;; none

;;; Code:

;; level faces
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.15))))
 '(org-level-4 ((t (:inherit outline-4 :slant normal :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.05))))
 )

;; hide leading stars
(setq org-hide-leading-stars t)

;; inline source highlight
(setq org-src-fontify-natively t)

;; org-babel
                                        ; supported languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (ruby . t)
   (dot . t)
   (ditaa . t)
   (perl . t)
   (latex . t))
 )

                                        ; window setup
(setq org-src-window-setup 'current-window)

;; org-bullets
(prelude-require-package 'org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-bullets-bullet-list
      '(
      ;;; Large
        "◉"
        "●"
        "○"
        "◆"
        "◇"
      ;;; Small
        "►"
        "•"
        "★"
        "▸"
        ))

;; org-present
(prelude-require-packages '(org-present))

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

;; org-reveal
(prelude-require-packages '(ox-reveal))
(require 'ox-reveal)
(setq org-reveal-root (concat "file://" (getenv "HOME") "/git/reveal.js"))
(setq org-reveal-mathjax t)

;; ox-confluence : confluence exporter
(prelude-require-packages '(org-plus-contrib))
(require 'ox-confluence)

;; add following whenever org-plus-contrib is updated
;;:menu-entry
;;'(?C "Export to Confluence Wiki"
;;     ((?R "To file" org-confluence-export-as-confluence)))


(provide 'org-goldbar)
;;; org-goldbar.el ends here
