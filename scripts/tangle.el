#!/usr/bin/emacs --script

(require 'org)
(require 'ox)
(require 'ob-tangle)

(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)))

(let* ((file (pop argv)))
  (with-current-buffer (find-file-noselect file)
    (org-export-expand-include-keyword)
    ;; (ignore-errors (org-babel-execute-buffer))
    (org-babel-tangle nil nil)))
