(add-to-list 'load-path prelude-personal-preload-dir)

;; load org elpa repository
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;; Proxy Setting
(require 'proxy-config)
(defvar goldbar/started nil)
(defun setup-proxy ()
  "Ask if you want to use proxy or not."
  (interactive)
  (if (y-or-n-p "Do you want to set up proxy? ")
      (progn
        (setenv "http_proxy" http-proxy-host)
        (setenv "https_proxy" https-proxy-host)
        (setq url-proxy-services
              ;;'(("no_proxy" . no-proxy-host)
              ;;("http" . http-proxy-host)
              ;;("https" . https-proxy-host))))
              '(("no_proxy" . "^\\(localhost\\|10.*\\|*.us.oracle.com\\|*.oracle.com\\)")
                ("http" . "www-proxy-hqdc.us.oracle.com:80")
                ("https" . "www-proxy-hqdc.us.oracle.com:80"))))
    (progn
      (setenv "http_proxy" "")
      (setenv "https-proxy-host" "")
      (setq url-proxy-services nil))))

(require 'server)
(if (not (server-running-p))
    (progn (setup-proxy)
           (server-start)))
