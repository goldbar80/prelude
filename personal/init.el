(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq goldbar/server-mode t)

(add-to-list 'load-path prelude-personal-dir)
;(let ((default-directory  "/usr/local/share/emacs/site-lisp"))
                                        ;  (normal-top-level-add-subdirs-to-load-path))

;; disable default theme (zenburn)
(disable-theme 'zenburn)
(require 'htmlize-goldbar)
(require 'helm-goldbar)
(require 'company-goldbar)
(require 'latex-goldbar)
(require 'e2wm-goldbar)
(require 'java-goldbar)
(require 'scala-goldbar)
(require 'groovy-goldbar)
(require 'misc-goldbar)
(require 'theme-goldbar)
(require 'mu4e-goldbar)
(require 'gradle-goldbar)
(require 'ess-goldbar)
