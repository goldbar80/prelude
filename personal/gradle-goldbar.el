(prelude-require-packages '(gradle-mode))

(gradle-mode)
(setq gradle-use-gradlew t)
(setq gradle-gradlew-executable "./gradlew")

(provide 'gradle-goldbar)
