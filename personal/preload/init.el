(add-to-list 'load-path prelude-personal-preload-dir)

;; load org elpa repository
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;; Proxy Setting
(require 'proxy-config)
(defun setup-proxy ()
  "Ask if you want to use proxy or not."
  (interactive)
  (if (y-or-n-p "Do you want to set up proxy? ")
      (progn
        (setenv "http_proxy" http-proxy-host)
        (setenv "https_proxy" https-proxy-host)
        (setq url-proxy-services
              '(("no_proxy" . no-proxy-host)
                ("http" . http-proxy-host)
                ("https" . https-proxy-host)))
        )
    )
  )
(setup-proxy)

(setq magit-last-seen-setup-instructions "1.4.0")
