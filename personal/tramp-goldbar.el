;; repect remote env vars.
;; http://emacs.stackexchange.com/questions/461/configuration-of-eshell-running-programs-from-directories-in-path-env-variable/2106#2106
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(setq vc-handled-backends '(RCS CVS SVN SCCS SRC Bzr Hg Mtn Git))

(provide 'tramp-goldbar)
