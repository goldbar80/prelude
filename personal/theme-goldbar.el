;;; theme-goldbar.el --- theme related config

;;; Commentary:
;; none

;;; code:
;; theme
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes"))

(prelude-require-packages '(moe-theme solarized-theme dracula-theme doom-themes neotree spacemacs-theme zerodark-theme))

(load-theme 'doom-one)

;; neo tree
(setq neo-theme (if window-system 'icons 'arrow))
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (if (neotree-show)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(global-set-key (kbd "C-c C-p") 'neotree-project-dir)

;; colorspace
(when (eq system-type 'darwin)
  (setq ns-use-srgb-colorspace nil))

(prelude-require-packages '(powerline spaceline eyebrowse persp-mode window-numbering anzu all-the-icons use-package fancy-battery yahoo-weather))

(require 'spaceline-config)
(setq powerline-default-separator 'bar)
(setq powerline-height 21)
(eyebrowse-mode 1)
(window-numbering-mode 1)
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
(setq spaceline-minor-modes-p nil)
(setq spaceline-which-function-p nil)
(setq spaceline-global-p nil)
(setq spaceline-version-control-p t)
(setq anzu-cons-mode-line-p nil)

(require 'all-the-icons)
(add-to-list 'all-the-icons-icon-alist '("\\.sc$" all-the-icons-alltheicon "scala" :face all-the-icons-red))
(add-to-list 'all-the-icons-icon-alist '("\\.sbt$" all-the-icons-fileicon "sbt" :face all-the-icons-blue))
(add-to-list 'all-the-icons-mode-icon-alist '(sbt-mode  all-the-icons-fileicon "sbt" :v-adjust -0.1))
(add-to-list 'all-the-icons-mode-icon-alist '(mu4e-headers-mode all-the-icons-octicon "mail-read"))
(add-to-list 'all-the-icons-mode-icon-alist '(mu4e-view-mode all-the-icons-octicon "mail-read"))

(setq yahoo-weather-location "San Jose, USA")
                                        ;(yahoo-weather-mode)

;; override existing segments
(spaceline-define-segment
    buffer-modified "An `all-the-icons' modified segment"
    (let* ((config-alist
            '(("*" all-the-icons-faicon-family all-the-icons-faicon "chain-broken" :height 1.2 :v-adjust -0.0)
              ("-" all-the-icons-faicon-family all-the-icons-faicon "link" :height 1.2 :v-adjust -0.0)
              ("%" all-the-icons-octicon-family all-the-icons-octicon "lock" :height 1.2 :v-adjust 0.1)))
           (result (cdr (assoc (format-mode-line "%*") config-alist))))

      (propertize (format "%s" (apply (cadr result) (cddr result))) 'face `(:family ,(funcall (car result)) :inherit )))
    :tight nil)

(spaceline-define-segment
    time "Time"
    (let* ((hour (string-to-number (format-time-string "%I")))
           (icon (all-the-icons-wicon (format "time-%s" hour) :v-adjust 0.0))
           (time (format-time-string "%H:%M ")))
      (concat
       (propertize time 'face `(:inherit))
       (propertize icon
                   'face `(:family ,(all-the-icons-wicon-family) :inherit)
                   'display '(raise 0.0))))
    :tight t)


(defun spaceline--get-temp ()
  "Function to return the Temperature formatted for ATI Spacline."
  (interactive)
  (let ((temp (yahoo-weather-info-format yahoo-weather-info "%(temperature)")))
    (unless (string= "" temp) (format "%s°C" (round (string-to-number temp))))))

(spaceline-define-segment
    weather "Weather"
    (let* ((weather (yahoo-weather-info-format yahoo-weather-info "%(weather)"))
           (temp (spaceline--get-temp))
           (help (concat "Weather is '" weather "' and the temperature is " temp))
           (icon (all-the-icons-icon-for-weather (downcase weather))))
      (concat
       (if (> (length icon) 1)
           (propertize icon 'help-echo help 'face `(:height 0.9 :inherit) 'display '(raise 0.1))
         (propertize icon
                     'help-echo help
                     'face `(:height 0.9 :family ,(all-the-icons-wicon-family) :inherit)
                     'display '(raise 0.0)))
       (propertize " " 'help-echo help)
       (propertize (spaceline--get-temp) 'face '(:height 0.9 :inherit) 'help-echo help)))
    :when (and active (boundp 'yahoo-weather-info) yahoo-weather-mode)
    :enabled t
    :tight nil)

(defun spaceline---github-vc ()
  "Function to return the Spaceline formatted GIT Version Control text."
  (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
    (concat
     (propertize (all-the-icons-alltheicon "git") 'face '(:height 1.1 :inherit) 'display '(raise 0.05))
     (propertize (format " %s" branch) 'face `(:inherit) 'display '(raise 0.1)))))

(defun spaceline---svn-vc ()
  "Function to return the Spaceline formatted SVN Version Control text."
  (let ((revision (cadr (split-string vc-mode "-"))))
    (concat
     (propertize (format " %s" (all-the-icons-faicon "cloud")) 'face `(:height 1.2) 'display '(raise -0.1))
     (propertize (format "·%s" revision) 'face `(:height 0.9)))))


(spaceline-define-segment
    version-control "An `all-the-icons' segment for the current Version Control icon"
    (when vc-mode
      (concat
       (cond ((string-match "Git[:-]" vc-mode) (spaceline---github-vc))
             ((string-match "SVN-" vc-mode) (spaceline---svn-vc))
             (t (propertize (format "%s" vc-mode))))
       (let ((icon (when (buffer-file-name)
                     (pcase (vc-state (buffer-file-name))
                       (`up-to-date (all-the-icons-faicon "thumbs-up"))
                       (`edited (all-the-icons-faicon "pencil"))
                       (`added (all-the-icons-faicon "plus"))
                       (`unregistered (all-the-icons-faicon "question"))
                       (`removed (all-the-icons-faicon "minus"))
                       (`needs-merge (all-the-icons-octicon "git-merge"))
                       (`needs-update (all-the-icons-octicon "arror-down"))
                       (`ignored (all-the-icons-wicon "moon-0"))
                       (`conflict (all-the-icons-wicon "lightening"))
                       (_ "")
                       ))))
         (propertize (format " %s" icon) 'face `(:inherit) 'display `(raise 0.1))
         )
       ))
    :when active)

(spaceline-define-segment
    major-mode "An `all-the-icons' segment for the current buffer mode"
    (let ((icon (all-the-icons-icon-for-buffer)))
      (unless (symbolp icon) ;; This implies it's the major mode
        (propertize icon
                    'help-echo (format "Major-mode: `%s`" major-mode)
                    'display '(raise 0.0)
                    'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer) :inherit)))))

(defun goldbar/ensime-modeline-string ()
  "The string to display in the modeline.
\"ENSIME\" only appears if we aren't connected. If connected,
include connection-name, and possibly some state information."
  (when ensime-mode
    (let ((icon (all-the-icons-faicon "codepen"))
          (status
           (condition-case err
               (let ((conn (ensime-connection-or-nil)))
                 (cond ((not conn)
                        (if (ensime-owning-server-process-for-source-file buffer-file-name)
                            (all-the-icons-faicon "hourglass-start")
                          (all-the-icons-wicon "lightening")
                          ))
                       ((ensime-connected-p conn)
                        (let ((config (ensime-config conn)))
                          (or (plist-get config :name)
                              "unknown project")))
                       (t "Dead Connection")))
             (error "Error"))))
      (concat
       (propertize icon 'face `(:family ,(all-the-icons-faicon-family) :inherit) 'display `(raise -0.04))
       " "
       status)
      )))


(spaceline-define-segment
    ensime "ensime status"
    (when (bound-and-true-p ensime-mode)
      (goldbar/ensime-modeline-string)))

(spaceline-spacemacs-theme `((ensime time) :separator " | ") )

(spaceline-helm-mode)
(spaceline-info-mode)

;; clippy
(prelude-require-package 'clippy)
(require 'clippy)
(setq clippy-tip-show-function #'clippy-popup-tip-show)

(provide 'theme-goldbar)
;;; theme-goldbar.el ends here
