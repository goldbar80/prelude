(prelude-require-packages '(org-page))
(require 'org-page)

;; for configuration, refer to 'http://codyreichert.github.io/posts/blogging-with-emacs-and-org-mode/'

(setq op/repository-directory "~/git/goldbar80.github.io")
(setq op/site-domain "http://goldbar80.github.io")
(setq op/personal-github-link "https://github.com/goldbar80")
(setq op/site-main-title "Meh....")
(setq op/site-sub-title "Emacs, Programming, and ....")
(setq op/personal-disqus-shortname "jinha_kim")
(setq op/theme 'wy)

(provide 'orgpage-goldbar)