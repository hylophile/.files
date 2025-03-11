;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "hylosevka" :size 18)
                         ;  :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Jost" :size 13))

(setq display-line-numbers-type nil)

(setq confirm-kill-emacs nil)
(setq doom-theme 'modus-vivendi)
(setq org-directory "~/org/")
(setq org-use-speed-commands t)
(setq org-return-follows-link t)
(setq org-agenda-tags-column 0)
(after! org
       (setq org-agenda-span 21))
(setq org-cite-global-bibliography  '("~/tub/references.bib"))

(after! org (setq org-startup-with-latex-preview t))

(xterm-mouse-mode +1)

;; better scaling for mixed-pitch-mode
(setq! face-font-rescale-alist '(("Jost" . 1.2)))

;; fix roam errror
(defun emacsql-sqlite-ensure-binary ())

(use-package! org-typst-preview)

(use-package! mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode)
  :config
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'corfu-default)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-property-value)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-drawer)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-special-keyword)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-transclusion-keyword))

(use-package! visual-fill-column
  :custom
  (visual-fill-column-center-text t)
  (visual-fill-column-width 100)
  (visual-fill-column-enable-sensible-window-split t)
  :hook
  (prog-mode . visual-fill-column-mode)
  (text-mode . visual-fill-column-mode)
  ;(special-mode . visual-fill-column-mode)
  )

(use-package citar
  :custom
  (citar-bibliography '("~/tub/references.bib"))
  :hook
  ;(LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup))

;; ~/.doom.d/config.el
(use-package! org-transclusion
  :after org
  :init
  (custom-set-faces! '(org-transclusion :inherit hl-line))
  (setq org-transclusion-exclude-elements '(property-drawer keyword))
  (map!
   :map doom-leader-notes-map
   :desc "Org Transclusion Mode" "u" #'org-transclusion-mode))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(map! :map doom-leader-notes-map "r c" #'citar-org-roam-ref-add)


(use-package! org-modern
  :custom
  (org-modern-star 'replace)
  (org-modern-replace-stars "❥⚘❥❦❥✿")
  (org-modern-table nil)
  (org-modern-label-border nil)
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))


(map! :after visual-fill-column :leader "t o" #'visual-fill-column-mode)
(map! "C-+" #'doom/increase-font-size)
(map! "C-=" #'doom/reset-font-size)
(map! "C--" #'doom/decrease-font-size)

(use-package! ob-rust)

; org export with modus-operandi theme
(add-to-list 'default-frame-alist '(alpha-background . 90))
(defun my/with-theme (theme fn &rest args)
  (let ((current-themes custom-enabled-themes))
    (mapcar #'disable-theme custom-enabled-themes)
    (load-theme theme t)
    (let ((result (apply fn args)))
      (mapcar #'disable-theme custom-enabled-themes)
      (mapcar (lambda (theme) (load-theme theme t)) current-themes)
      result)))
(advice-add #'org-export-to-file :around (apply-partially #'my/with-theme 'modus-operandi))
(advice-add #'org-export-to-buffer :around (apply-partially #'my/with-theme 'modus-operandi))

(setq org-timeblock-span 14
      org-timeblock-show-future-repeats t
      org-timeblock-show-outline-path t
      org-timeblock-tag-colors '(("@uni" . modus-themes-grue)
                                 ("@online" . modus-themes-mark-alt)
                                 ("@homework" . modus-themes-mark-del)
                                 ("@work" . modus-themes-mark-sel)
                                 ("@todo" . org-level-3))
      org-timeblock-scale-options '(8 . 20))

; We don't need this file in recentf.
(after! recentf
  (add-to-list 'recentf-exclude ".*/etc/workspaces/autosave"))

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
