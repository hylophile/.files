;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "hylosevka" :size 18
                           :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Jost" :size 13))

(setq confirm-kill-emacs nil)
(setq doom-theme 'doom-challenger-deep)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")


(defun org-archive-done-tasks ()
  (interactive)
  (mapc (lambda(entry)
          (goto-char entry)
          (org-archive-subtree))
        (reverse (org-map-entries (lambda () (point)) "TODO=\"DONE\"" 'file))))

;; A bit of setup for managing a bare dotfile repository. We check whether the
;; current =default-directory= belongs to our dotfiles with =git ls-files=. If
;; it does, we add our dotfile environment. We also memoize previous calls to
;; =git=, since magit calls =magit-process-environment= quite often (~25 times
;; per =magit-status=), which slows down every =magit=-command with our advice.
;; inspired by https://github.com/magit/magit/issues/460#issuecomment-1475082958
(setq hy/dotfile-dirs ())

(defun hy/magit-process-environment (env)
  "Detect and set git -bare repo env vars when in tracked dotfile directories."
  (let* ((git-dir (expand-file-name "~/.dotfiles/"))
         (work-tree (expand-file-name "~/"))
         (default (file-name-as-directory (expand-file-name default-directory))))
    (unless (assoc default hy/dotfile-dirs)
      (push (cons default (eq 0 (call-process "/usr/bin/env" nil nil nil
                                              "git"
                                              (format "--git-dir=%s" git-dir)
                                              (format "--work-tree=%s" work-tree)
                                              "ls-files"
                                              "--error-unmatch"
                                              default)))
            hy/dotfile-dirs))
    (when (cdr-safe (assoc default hy/dotfile-dirs))
      (push (format "GIT_WORK_TREE=%s" work-tree) env)
      (push (format "GIT_DIR=%s" git-dir) env)))
  env)

(advice-add 'magit-process-environment
            :filter-return #'hy/magit-process-environment)


;; When we want to add a new untracked dotfile in a new directory, we have no
;; way of knowing that it's a dotfile with the above advice. As a workaround, we
;; just stage the file in our dotfiles if there's no =magit-gitdir=, and
;; otherwise fallback to =magit-stage-file= (which otherwise works as expected
;; in known dotfile directories, even for untracked files).

(defun hy/magit-stage-file ()
  (interactive)
  (if (magit-gitdir)
      (call-interactively #'magit-stage-file)
    (shell-command (concat
                    "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add "
                    (buffer-file-name))
                   t)))

(map! :after magit :leader "g S" #'hy/magit-stage-file)
