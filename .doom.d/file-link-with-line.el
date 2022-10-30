;;; file-link-with-line.el -*- lexical-binding: t; -*-
(defun link-hint--find-file-link (&optional start-bound end-bound)
  "Find the first file link.
Only search the range between just after START-BOUND and END-BOUND."
  (save-excursion
    (let ((start-bound (or start-bound (window-start)))
          (end-bound (or end-bound (window-end)))
          file-link-pos)
      (goto-char start-bound)
      (while (and
              (setq file-link-pos
                    (link-hint--find-regexp link-hint-maybe-file-regexp
                                            (point) end-bound))
              (progn
                (goto-char file-link-pos)
                (when (looking-at (rx blank))
                  (forward-char)
                  (setq file-link-pos (point)))
                t)
              (not (ffap-file-at-point))))
      (when (and file-link-pos
                 (ffap-file-at-point))
        file-link-pos))))

(defadvice find-file (around find-file-line-number
                             (filename &optional wildcards)
                             activate)
  "Turn files like file.cpp:14 into file.cpp and going to the 14-th line."
  (save-match-data
    (let* ((matched (string-match "^\\(.*\\):\\([0-9]+\\):?$" filename))
           (line-number (and matched
                             (match-string 2 filename)
                             (string-to-number (match-string 2 filename))))
           (filename (if matched (match-string 1 filename) filename)))
      ad-do-it
      (when line-number
        ;; goto-line is for interactive use
        (goto-char (point-min))
        (forward-line (1- line-number))))))

(defun find-file-at-point-with-line()
  "if file has an attached line num goto that line, ie boom.rb:12"
  (interactive)
  (setq line-num 0)
  (save-excursion
    (search-forward-regexp "[^ ]:" (point-max) t)
    (if (looking-at "[0-9]+")
         (setq line-num (string-to-number (buffer-substring (match-beginning 0) (match-end 0))))))
  (find-file (ffap-guesser))
  (if (not (equal line-num 0))
      (goto-line line-num)))

(link-hint-define-type 'file-link
  :next #'link-hint--next-file-link
  :at-point-p #'ffap-file-at-point
  ;; TODO consider making file links opt-in (use :vars)
  :not-vars '(org-mode Info-mode)
  :open #'h/t
  :copy #'kill-new)

(defun h/t ()
  "goto line and column number of file at point, for example ~/woop.el:202:13
useful for link-hint-open-link "
  (interactive)
  (save-match-data
    (let* ((line-content (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
           (matched (string-match ":\\([0-9]+\\):?\\([0-9]*\\)$" line-content))
           (line-number (and matched
                             (match-string 1 line-content)
                             (string-to-number (match-string 1 line-content))))
           (col-number (and matched
                             (match-string 2 line-content)
                             (string-to-number (match-string 2 line-content))))
           )
           (find-file (ffap-guesser))
           (when line-number
             (goto-char (point-min))
             (forward-line (- line-number 1)))
           (when (> col-number 0)
             (move-to-column (- col-number 1)))
           )))

(defun h/l ()
  (let ((link-hint-restore)))
  (link-hint-open-link))


(defun link-hint-aw-select ()
  "Use avy to open a link in a window selected with ace-window."
  (interactive)
  (unless
      (avy-with link-hint-aw-select
        (link-hint--one :file-here))
    (message "No visible links")))

(defun link-hint--aw-select-file-link (link)
  (with-demoted-errors "%s"
    ;;(aw-switch-to-window (aw-select nil))
    ;; (aw-flip-window)
    (select-window (get-mru-window))
    (find-file link)))

(link-hint-define-type 'file-link
  :aw-select #'link-hint--aw-select-file-link)


(link-hint-define-type 'file-link
  :file-here #'hylo/find-file-at-point-with-pos)
