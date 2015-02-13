;;; e2wm-goldbar.el --- e2wm config

;;; Commentary:
;;; none

;;; Code:

(prelude-require-packages '(e2wm))

(require 'e2wm)
(require 'e2wm-vcs)

;; add keybinding for code perspective
(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(
   ("prefix i" . e2wm:dp-code-navi-imenu-command)
   ("prefix h" . e2wm:dp-code-navi-history-command)
   ("prefix m" . e2wm:dp-code-navi-main-command)
   ("prefix f" . e2wm:dp-code-navi-files-command)
   ("prefix 6" . e2wm:dp-magit))
 e2wm:prefix-key)

(provide 'e2wm-goldbar)
;;; e2wm-goldbar.el ends here
