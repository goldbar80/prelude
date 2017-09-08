(require 'ox-confluence)

;; Define the backend itself
(org-export-define-derived-backend 'goldbar/confluence 'confluence
  :translate-alist '((paragraph . goldbar/org-confluence-paragraph)
                     (headline . goldbar/org-confluence-headline)
                     (link . goldbar/org-confluence-link)
                     (src-block . goldbar/org-confluence-src-block)
                     (verbatim . goldbar/org-confluence-verbatim)
                     (code . goldbar/org-confluence-verbatim)
                     (table-row . goldbar/org-confluence-table-row)
                     (table-cell . goldbar/org-confluence-table-cell))
  )


(defun goldbar/org-confluence-headline (headline contents info)
  (let* ((low-level-rank (org-export-low-level-p headline info))
	 (text (org-export-data (org-element-property :title headline)
				info))
	 (todo (org-export-data (org-element-property :todo-keyword headline)
				info))
	 (level (org-export-get-relative-level headline info)))
    ;; Else: Standard headline.
    (format "h%s. %s\n%s" level text
            (if (org-string-nw-p contents) contents ""))))


(defun goldbar/org-confluence-verbatim (verbatim desc info)
  (let ((raw-text (org-element-property :value verbatim)))
    (format "\{\{%s\}\}" raw-text)))

(defun goldbar/org-confluence-link (link desc info)
  (let* ((raw-link (org-element-property :raw-link link))
        (file-name (file-name-nondirectory raw-link))
        (ext (file-name-extension raw-link)))
    (cond
     ((org-export-custom-protocol-maybe link desc 'goldbar/confluence))
     ((string= ext "png") (concat "!" file-name "|width=!"))
     (t
      (concat "["
            (when (org-string-nw-p desc) (format "%s|" desc))
            (cond
             ((string-match "^confluence:" raw-link)
              (replace-regexp-in-string "^confluence:" "" raw-link))
             (t
              raw-link))
            "]")))))

(defun goldbar/org-confluence-src-block (src-block contents info)
  ;; FIXME: provide a user-controlled variable for theme
  (let* ((lang (org-element-property :language src-block))
         (language (or (cdr (assoc lang org-confluence-lang-alist)) lang))
         (content (org-export-format-code-default src-block info)))
    (org-confluence--block language "Confluence" content)))


(defun goldbar/org-confluence-paragraph (paragraph contents info)
  (org-ascii--fill-string
   (if (not (wholenump org-ascii-indented-line-width)) contents
     (concat
      ;; Do not indent first paragraph in a section.
      (unless (and (not (org-export-get-previous-element paragraph info))
                   (eq (org-element-type (org-export-get-parent paragraph))
                       'section))
        (make-string org-ascii-indented-line-width ?\s))
      (replace-regexp-in-string "\\`[ \t]+" "" contents)))
   (point-max) info))


(defun goldbar/org-confluence-table-row  (table-row contents info)
  (concat
   (if (org-string-nw-p contents) (format "|%s" contents)
     "")
   (when (org-export-table-row-ends-header-p table-row info)
     "|")))

(defun goldbar/org-confluence-table-cell  (table-cell contents info)
  (let ((table-row (org-export-get-parent table-cell)))
    (concat
     (when (org-export-table-row-starts-header-p table-row info)
       "| ")
     contents " |")))


(defun goldbar/org-confluence-export-as-confluence
  (&optional async subtreep visible-only body-only ext-plist)
  "Export current buffer to a text buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, strip title, table
of contents and footnote definitions from output.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org CONFLUENCE Export*\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil."
  (interactive)
  (org-export-to-buffer 'goldbar/confluence "*org CONFLUENCE Export*"
    async subtreep visible-only body-only ext-plist (lambda () (text-mode))))

(add-to-list 'org-export-backends 'goldbar/confluence)


(provide 'ox-confluence-goldbar)
