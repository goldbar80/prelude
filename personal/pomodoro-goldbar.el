(prelude-require-packages '(org-pomodoro tomatinho))

;; org-pomodoro
(prelude-require-packages '(org-pomodoro))

(setq org-pomodoro-keep-killed-pomodoro-time t)
                                        ; shortcut
(global-set-key (kbd "C-c C-x C-i") 'org-pomodoro)
(global-set-key (kbd "C-c C-x C-o") 'org-pomodoro)
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-x C-i") 'org-pomodoro)
            (local-set-key (kbd "C-c C-x C-o") 'org-pomodoro))
          'append)
                                        ; agenda shortcut
(defun pomodoro-org-agenda-mode-defaults ()
  (org-defkey org-agenda-mode-map "I" 'org-pomodoro)
  (org-defkey org-agenda-mode-map "O" 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-o") 'org-pomodoro))

(add-hook 'org-agenda-mode-hook 'pomodoro-org-agenda-mode-defaults 'append)


                                        ; Needs terminal-notifier (brew install terminal-notifier)
(defun notify-system (title message)
  (if (eq system-type 'darwin)
      (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-message" message)
    (call-process "notify-send"
                  nil 0 nil
                  title message)))

                                        ; org-pomodoro mode hooks

(add-hook 'org-pomodoro-started-hook
          (lambda ()
            (tomatinho-interactive-new-pomodoro)))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (notify-system "Pomodoro completed!" "Time for a break.")))
(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()
            (notify-system "Pomodoro Short Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-long-break-finished-hook
          (lambda ()
            (notify-system "Pomodoro Long Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (notify-system "Pomodoro Killed" "One does not simply kill a pomodoro!")))
