


;; (defun hylo/format-classes ()
;;   (interactive)
;;   (save-excursion
;;     (re-search-forward-lax-whitespace "class=\"")
;;     (insert "\n")
;;     ;; (re-search-forward "\\([[:space:]]\\|\"\\)")
;;     ;; (unless (eq ?" (char-after)))
;; ))

(defun hylo/format-classes ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (re-search-forward "class=\"")
    (while (re-search-forward
            "[[:space:]]+\n*[[:space:]]*"
            (save-excursion
              (re-search-forward "\"")
              (point)))
      (unless (eq "\"" (char-after)) (replace-match "\n"))
      (indent-according-to-mode))))
