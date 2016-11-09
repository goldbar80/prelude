(prelude-require-packages '(erc-colorize erc-hl-nicks erc-image erc-terminal-notifier))

(require 'erc-colorize)
(erc-colorize-mode 1)

(require 'erc-hl-nicks)

(require 'erc-terminal-notifier)

;; enable logging
;; from http://www.nihamkin.com/2013/12/04/how-to-enable-logging-of-chat-sessions-in-erc/

;; it is not possible to set erc-log-mode variable directly
(erc-log-mode)
;; The directory should be created by user.
(setq erc-log-channels-directory "~/.erc/logs/")
(setq erc-generate-log-file-name-function (quote erc-generate-log-file-name-with-date))
(setq erc-save-buffer-on-part nil)
(setq erc-save-queries-on-quit nil)
(setq erc-log-write-after-insert t)
(setq erc-log-write-after-send t)
(setq erc-log-insert-log-on-open t)

(provide 'erc-goldbar)
