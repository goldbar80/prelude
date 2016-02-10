;;; company-goldbar.el -- company config

;;; Commentary:
;;

;;; Code:
(require 'mu4e)
(setq mu4e-maildir "~/Maildir")
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent Messages")
;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; shortcuts
(setq mu4e-maildir-shortcuts
      '(("/INBOX"               . ?i)
        ("/Sent Messages"       . ?s)
        ))

;; something about ourselves
(setq
   user-mail-address "jinha.kim@oracle.com"
   user-full-name  "Jinha Kim"
   mu4e-compose-signature
    (concat
      "Cheers,\n"
      "Jinha\n"))

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; convert html emails properly
;; Possible options:
;;   - html2text -utf8 -width 72
;;   - textutil -stdin -format html -convert txt -stdout
;;   - html2markdown | grep -v '&nbsp_place_holder;' (Requires html2text pypi)
;;   - w3m -dump -cols 80 -T text/html
;;   - view in browser (provided below)
;;(setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")
(setq mu4e-html2text-command "html2text -utf8 -width 80 -style pretty -nobs")

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)))

;; add option to view html message in a browser
;; `aV` in view to activate
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)
(add-to-list 'mu4e-view-actions
             '("test" . mu4e-action-view-with-xwidget) t)

;; fetch mail every 5 mins
(setq mu4e-update-interval 300)

;; notifications
(mu4e-alert-enable-mode-line-display)
(mu4e-alert-enable-notifications)
(mu4e-alert-set-default-style 'notifier)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      auth-sources (quote (macos-keychain-internet oacos-keychain-generic))
      smtpmail-default-smtp-server "stbeehive.oracle.com"
      smtpmail-smtp-server "stbeehive.oracle.com"
      smtpmail-smtp-service 465
      smtpmail-smtp-user "jinha.kim@oracle.com"
      smtpmail-stream-type (quote ssl)
      smtpmail-debug-info t)


(provide 'mu4e-goldbar)
;;; mu4e-goldbar.el ends here
