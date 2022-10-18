;; [[file:config.org::*hi][hi:1]]
;;; -*- lexical-binding: t; -*-
;; hi:1 ends here

;; [[file:config.org::*hi][hi:2]]
(setq projectile-project-search-path '("~/code"))
;; hi:2 ends here

;; [[file:config.org::*basics][basics:1]]
(setq doom-leader-alt-key "C-c")
;; (remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)
;; (setq evil-want-C-u-delete nil)
(map! :map minibuffer-local-map "C-u" #'universal-argument)

(map! :map minibuffer-local-map doom-leader-alt-key #'doom/leader)
;; (add-hook 'minibuffer-setup-hook #'general-override-mode)

(map! :i "C-u" #'universal-argument)

(setq auth-sources '("~/.authinfo"))
;; (map! :after evil :v "i" #'evil-forward-char)
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "name"
      user-mail-address "mail")
(setq display-line-numbers-type 'relative)

(setq which-key-idle-delay 0.3)


(setq auth-sources '("~/.authinfo"))
(after! forge
  (setq forge-add-pullreq-refspec nil)
  (add-to-list 'forge-alist
               '("gitlab.employer"
                 "gitlab.employer/api/v4"
                 "gitlab.employer" forge-gitlab-repository)))

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 5
      hscroll-margin 10)                            ; It's nice to maintain a little margin

(global-subword-mode t)                           ; Iterate through CamelCase words




(setq confirm-kill-emacs nil)
;; basics:1 ends here

;; [[file:config.org::*fonts][fonts:1]]
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq
 ;; doom-font (font-spec :family "Fira Code" :size 10.0)
 ;; doom-font (font-spec :family "JuliaMono" :size 10.0)
 ;; doom-font (font-spec :family "JuliaMono" :size 10.0)
 doom-font (font-spec :family "JetBrains Mono" :size 11.0)
 ;; doom-font (font-spec :family "DM Mono" :size 11.0)
 ;; doom-font (font-spec :family "Fantasque Sans Mono" :size 13.0)
 ;; doom-font (font-spec :family "Operator Mono" :weight 'normal :size 13.0)
 ;; doom-font (font-spec :family "IBM Plex Mono" :size 13.0)
 ;; doom-font (font-spec :family "Recursive Mono Casual Static" :size 11.0 :weight 'semi-light)
 ;; doom-font (font-spec :family "Victor Mono" :size 10.0)
 ;; doom-font (font-spec :family "Victor Mono" :size 10.0)
 ;; doom-variable-pitch-font (font-spec :family "Jost*" :size 13.0)
 doom-variable-pitch-font (font-spec :family "Overpass" :size 10.0))

(setq doom-font-increment 1)
;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
                                        ;test

;; (custom-set-faces! '(font-lock-comment-face :slant italic :family "Victor Mono"))
(custom-set-faces! '(font-lock-comment-face :slant italic :weight normal))
;; fonts:1 ends here

;; [[file:config.org::*avy][avy:1]]
(use-package! avy
  :config
  (setq avy-all-windows t))
;; avy:1 ends here

;; [[file:config.org::*all stuff][all stuff:1]]
;; (setq doom-theme (hylo/random-dark-theme))
;; (setq doom-theme 'ef-spring)
(setq doom-theme 'doom-dracula)

;;
;; (setq +doom-dashboard-functions (append
;;                                  (list (car +doom-dashboard-functions))
;;                                  '(hylo/insert-theme)
;;                                  (cdr +doom-dashboard-functions)))

(setq doom-themes-treemacs-theme "doom-colors")

(setq vterm-always-compile-module t)
;; (custom-set-faces! '((flycheck-fringe-error) :width expanded))

;; (map! :leader :desc "Actions" "e" #'embark-act)

(setq dired-dwim-target t)

(defmacro nsa! (&rest body)
  `(when (string= "nsa" (system-name)) ,@body))

(defmacro rook! (&rest body)
  `(when (string= "rook" (system-name)) ,@body))

(use-package! page-break-lines
  :hook
  (emacs-lisp-mode . page-break-lines-mode))

(map! :leader :desc "Undo tree" :n "U" #'vundo)
(after! vundo
  (setq vundo-glyph-alist vundo-unicode-symbols))

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:/]?\\(?:a-\\)?\\(.*\\)") . (nil . "ຯ\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "ຯ\\1"))))

(setq
 window-divider-default-bottom-width 1
 window-divider-default-right-width 5)

(setq doom-modeline-modal-icon nil)
(advice-add #'doom-modeline-segment--modals :override #'ignore)
(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t)
  :config)

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(map! :leader
      "t n" #'rainbow-mode
      "t t" #'+vterm/toggle
      "t T" #'+vterm/here)

(defun my/info-buffer-p (buf)
  (string= (buffer-name buf) "*info*"))
(push 'my/info-buffer-p doom-real-buffer-functions)

(defun my/helpful-buffer-p (buf)
  (string-prefix-p "*helpful" (buffer-name buf)))
(push 'my/helpful-buffer-p doom-real-buffer-functions)

(map! :map helpful-mode-map :n
      "K" #'+popup/raise
      "<ESC>" #'+popup/quit-window)

;; (defun my/search-info-org ()
;;   (interactive)
;;   (info "org")
;;   (+popup/raise (selected-window))
;;   (+default/search-buffer))
;; (defun my/search-info-elisp ()
;;   (interactive)
;;   (info "elisp")
;;   (+popup/raise (selected-window))
;;   (+default/search-buffer))
;; (defun my/search-emacsd ()
;;   (interactive)
;;   (+vertico/project-search t nil "~/.emacs.d"))
;; (map! :leader :prefix "s"
;;       ;; "e" #'my/search-emacsd
;;       "E" #'my/search-info-elisp
;;       "n" #'my/search-info-org)



;; (map! :n "C-a" #'evil-numbers/inc-at-pt-incremental)
;; (map! :n "C-x" #'evil-numbers/inc-at-pt-incremental)
;; 10
(map! :nv "C-." #'embark-act)
(map! [remap describe-bindings] #'embark-bindings
      "C-."               #'embark-act
      (:map minibuffer-local-map
            "C-."               #'embark-act
            "C-c C-."           #'embark-export))

(after! latex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))
(setq +latex-viewers '(zathura pdf-tools evince okular skim sumatrapdf))

(map! :map cdlatex-mode-map "'" nil)


(setq web-mode-script-padding 4)
(setq doom-modeline-vcs-max-length 30)
;; (setq doom-leader-alt-key "<f8>")
;; (setq doom-localleader-alt-key "<f8> m")

(use-package! emacs-everywhere
  :config
  ;; (set-company-backend! 'emacs-everywhere-mode 'company-elisp)
  ;; (add-hook! 'emacs-everywhere-init-hooks
  ;;   (lambda ()
  ;;     (set (make-local-variable 'company-backends)
  ;;          (append (car company-backends)
  ;;                  (list 'company-elisp)))))
  (defadvice! my/emacs-everywhere-position ()
    :override #'emacs-everywhere-set-frame-position
    ()))


(delete "Noto Color Emoji" doom-emoji-fallback-font-families)

(defun rc/find-file-recursive ()
  (interactive)
  (let* ((cwd (file-name-directory (buffer-file-name)))
         (files (directory-files-recursively cwd ""))
         (files-without-cwd (mapcar (lambda (f) (string-remove-prefix cwd f)) files)))
    (find-file (completing-read (format "Find file [%s]: " cwd) files-without-cwd nil t))))

(load! "load/mail.el")
(load! "load/dotfiles.el")
;;(load! "load/format-classes.el")
;;(load! "load/kzk-config.el")
;; (after! org
;;   (add-to-list 'org-agenda-custom-commands
;;                '("y" "year"
;;                  agenda ""
;;                  ((org-agenda-span 'year)))))
(map! :leader
      :desc "FuZzily find File in home"
      "f z f" (cmd!! #'affe-find "~/"))
(map! :leader
      :desc "FuZzily find file in this Dir"
      "f z d" (cmd!! #'affe-find))

(remove-hook! 'doom-modeline-mode-hook #'size-indication-mode)


(nsa!
 (load! "load/kzk-config.el" nil t))

;; (map!
;;  :after (evil-snipe evil)
;;                     :m "," #'evil-snipe-repeat)
;; (setq evil-snipe-override-evil-repeat-keys nil)
(after! evil-snipe
  ;; (when evil-snipe-override-evil-repeat-keys
  (define-key evil-snipe-parent-transient-map "," #'evil-snipe-repeat)
  (define-key evil-snipe-parent-transient-map ";" #'evil-snipe-repeat-reverse)

  (evil-define-key* '(motion normal) evil-snipe-local-mode-map
    "S" nil
    "," 'evil-snipe-repeat
    ";" 'evil-snipe-repeat-reverse)
  (evil-define-key* '(normal) evil-snipe-override-local-mode-map
    "," 'evil-snipe-repeat
    ";" 'evil-snipe-repeat-reverse)


  (map! :n "S" #'avy-goto-char-2)
  )

(map! :map magit-mode-map
      "<escape>" #'+magit/quit)

;; (use-package! spookfox
;;   :config
;;   (setq spookfox-saved-tabs-target
;;         `(file+headline ,(expand-file-name "spookfox.org" org-directory) "Tabs"))
;;   (spookfox-init))

(use-package! apheleia
  :config
  (apheleia-global-mode +1))

(use-package! ef-themes)

(defun save-all ()
  (interactive)
  (save-some-buffers t))


(add-function :after after-focus-change-function (cmd! (save-some-buffers t)))

;; (use-package! company-quickhelp)

;; (map! :map emmet-mode-keymap
;;       [tab] #'indent-for-tab-command)

(after! company
  (add-hook! 'evil-normal-state-entry-hook
    (defun +company-abort-h ()
      ;; HACK `company-abort' doesn't no-op if company isn't active; causing
      ;;      unwanted side-effects, like the suppression of messages in the
      ;;      echo-area.
      ;; REVIEW Revisit this to refactor; shouldn't be necessary!
      (when company-candidates
        (company-abort))))

  (setq company-idle-delay 0.3))



(after! flycheck
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow [224]
          nil nil '(center repeated)))
;; all stuff:1 ends here

;; [[file:config.org::*maps][maps:1]]
(map! :ni "C-+" #'doom/increase-font-size)
(map! :ni "C-=" #'doom/reset-font-size)
(map! :ni "C--" #'doom/decrease-font-size)

(map! :leader
      :desc "Magit push"
      "g p" #'magit-push)

(setq avy-keys '(?t ?n ?s ?e ?r ?i ?a ?o ?d ?h ?f ?u ?p ?l ?w ?y ?c ?, ?x ?. ?g ?m ?v ?k))

(map! :leader
      "|" #'+popup/raise)

(defun insert-primary ()
  (interactive)
  (insert-for-yank (gui-get-primary-selection)))

;; (map! :nv "s" #'avy-goto-char-2)

(map! :niv "<269025133>" #'insert-primary)

(map! :map evil-window-map
      "n" #'evil-window-left
      "r" #'evil-window-down
      "t" #'evil-window-up
      "d" #'evil-window-right

      "S-n" #'+evil/window-move-left
      "S-r" #'+evil/window-move-down
      "S-t" #'+evil/window-move-up
      "S-d" #'+evil/window-move-right

      ;; "n" #'evil-window-new
      ;; "r" #'evil-window-rotate-downwards
      ;; "R" #'evil-window-rotate-upwards
      ;; "t" #'evil-window-top-left
      ;; "T" #'tear-off-window
      ;; "k" #'+workspace/close-window-or-workspace

      "k" #'evil-window-delete

      "v" #'+evil/window-vsplit-and-follow
      "V" #'evil-window-vsplit
      "h" #'+evil/window-split-and-follow
      "H" #'evil-window-split
      "C-h" nil
      "j" nil
      "J" nil
      "C-j" nil
      "k" nil
      "K" nil
      "C-k" nil
      "l" nil
      "L" nil
      "C-l" nil
      "s" nil
      "S" nil
      "C-s" nil)

(map! :leader "TAB p" #'+workspace/other)

(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)
;; maps:1 ends here

;; [[file:config.org::*org mode][org mode:1]]
(setq org-directory "~/org/")

(defvar org-refile-region-format "\n%s\n")

(defvar org-refile-region-position 'top
  "Where to refile a region. Use 'bottom to refile at the
end of the subtree. ")

(defun org-refile-region (beg end copy)
  "Refile the active region.
If no region is active, refile the current paragraph.
With prefix arg C-u, copy region instad of killing it."
  (interactive "r\nP")
  ;; mark paragraph if no region is set
  (unless (use-region-p)
    (setq beg (save-excursion
                (backward-paragraph)
                (skip-chars-forward "\n\t ")
                (point))
          end (save-excursion
                (forward-paragraph)
                (skip-chars-backward "\n\t ")
                (point))))
  (let* ((target (save-excursion (org-refile-get-location)))
         (file (nth 1 target))
         (pos (nth 3 target))
         (text (buffer-substring-no-properties beg end)))
    (unless copy (kill-region beg end))
    (deactivate-mark)
    (with-current-buffer (find-file-noselect file)
      (save-excursion
        (goto-char pos)
        (if (eql org-refile-region-position 'bottom)
            (org-end-of-subtree)
          (org-end-of-meta-data))
        (insert (format org-refile-region-format text))))))


(map! :map org-mode-map
      :leader
      "r" #'org-refile-region
      "d" (cmd! (org-todo "DONE"))
      "D" #'org-archive-done-tasks)

(setq org-agenda-mouse-1-follows-link t)
(setq org-tags-column 0)
(setq org-agenda-tags-column 0)

;; (setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))
(setq org-agenda-files '("~/org" "~/org/issues"))


(setq org-agenda-format-date (lambda (date) (concat "\n"
                                                    (org-agenda-format-date-aligned date))))

(after! org
  (setq org-agenda-start-day "0d"
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-timestamp-if-done t))



(custom-set-faces!
  '(org-document-title :height 1.1))
(custom-set-faces!
  `(org-agenda-diary :foreground ,(doom-color 'magenta) :weight bold))




(after! doom-themes
  (custom-set-faces!
    '(outline-1 :weight semi-bold :height 1.15)
    '(outline-2 :weight semi-bold :height 1.10)
    '(outline-3 :weight semi-bold :height 1.09)
    '(outline-4 :weight semi-bold :height 1.06)
    '(outline-5 :weight semi-bold :height 1.03)
    '(outline-6 :weight semi-bold :height 1.00)
    '(outline-7 :weight semi-bold :height 1.00)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold)))



(map! :localleader :map org-mode-map "~" (cmd! (org-toggle-checkbox '(16))))


(setq org-cycle-max-level 5)


(defadvice! my/hide-archived-on-global-cycle (&rest _)
  "For some reason org-content (i.e. <number>S-<TAB>) does not
respect the hidden status of archived headings and shows them.
This hides them again."
  :after #'org-content
  (org-fold-hide-archived-subtrees (point-min) (point-max)))


(setq org-archive-location "~/org/archive/%s_archive::")

;; (add-hook 'org-cycle (cmd! (org-hide-archived-subtrees (point-min) (point-max))))

(setq org-agenda-format-date (lambda (date) (concat "\n"
                                                    (make-string (window-width) 9472)
                                                    "\n"
                                                    (org-agenda-format-date-aligned date))))

(use-package! org-roam
  :config
  (setq org-roam-capture-last-used-template "d")
  (defadvice! hy/after-roam-capture (&optional GOTO KEYS &key FILTER-FN TEMPLATES INFO)
    :after #'org-roam-capture
    (message KEYS)
    (setq org-roam-capture-last-used-template KEYS))
  (defun hylo/org-roam-capture-last-used-template ()
    (interactive)
    (org-roam-capture :keys org-roam-capture-last-used-template))
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain "%?" :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("u" "Uni related note")
     ("ua" "Algorithmic Game Theory" plain (file "~/org/roam/templates/agt.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-uni-agt-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("uw" "Web technologies" plain (file "~/org/roam/templates/wt.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-uni-wt-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("um" "Machine Learning" plain (file "~/org/roam/templates/ml.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-uni-ml-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("ug" "Computer Graphics" plain (file "~/org/roam/templates/cg.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-uni-cg-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t))))




;; (use-package! websocket
;;   :after org-roam)



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



(setq
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…")


(defun unpackaged/org-fix-blank-lines (&optional prefix)
  "Ensure that blank lines exist between headings and between headings and their contents.
With prefix, operate on whole buffer. Ensures that blank lines
exist after each headings's drawers."
  (interactive "P")
  (org-map-entries (lambda ()

                     (org-with-wide-buffer
                      ;; `org-map-entries' narrows the buffer, which prevents us from seeing
                      ;; newlines before the current heading, so we do this part widened.
                      (while (not (looking-back "\n\n" nil))
                        ;; Insert blank lines before heading.
                        (insert "\n")))
                     (let ((end (org-entry-end-position)))
                       ;; Insert blank lines before entry content
                       (forward-line)
                       (while (and (org-at-planning-p)
                                   (< (point) (point-max)))
                         ;; Skip planning lines
                         (forward-line))
                       (while (re-search-forward org-drawer-regexp end t)
                         ;; Skip drawers. You might think that `org-at-drawer-p' would suffice, but
                         ;; for some reason it doesn't work correctly when operating on hidden text.
                         ;; This works, taken from `org-agenda-get-some-entry-text'.
                         (re-search-forward "^[ \t]*:END:.*\n?" end t)
                         (goto-char (match-end 0)))
                       (unless (or (= (point) (point-max))
                                   (org-at-heading-p)
                                   (looking-at-p "\n"))
                         (insert "\n"))))
                   t (if prefix
                         nil
                       'tree)))



(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))


(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'file))




(setq org-agenda-include-diary t
      holiday-bahai-holidays nil
      holiday-hebrew-holidays nil
      holiday-islamic-holidays nil
      holiday-oriental-holidays nil)


(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "Tag der Arbeit")
        (holiday-fixed 3 8 "Internationaler Frauentag")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))


(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")))
(setq org-agenda-show-outline-path t)
(setq org-agenda-time-grid nil)
(setq org-agenda-show-current-time-in-grid nil)
;; (setq org-agenda-prefix-format "%i  %?-12t% s")
(setq org-agenda-prefix-format "  %i  %-12t% s")

(after! org-agenda
  (org-super-agenda-mode))

(setq org-superstar-headline-bullets-list "●⚬")

(use-package! mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode)
  )
;; org mode:1 ends here

;; [[file:config.org::*lsp][lsp:1]]
(setq +format-with-lsp nil)
(after! lsp-ui
(setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
lsp-ui-doc-enable nil))
;; lsp:1 ends here

;; [[file:config.org::*windows][windows:1]]
(map! :leader
      "a" #'ace-window)

(defun hylo/split-window-fair-and-follow ()
  "Split current window vertically or horizontally, based on its
 current dimensions. Use evil's window splitting function to
 follow into the new window."
  (let* ((window (selected-window))
         (w (window-body-width window))
         (h (window-body-height window)))
    (if (< (* h 2.2) w)
        (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
          (call-interactively #'evil-window-vsplit))
      (let ((evil-split-window-below (not evil-split-window-below)))
        (call-interactively #'evil-window-split)))))

(map! :map evil-window-map "s" #'hylo/split-window-fair-and-follow)


(custom-set-faces!
  `(aw-leading-char-face
    :foreground ,(face-attribute 'mode-line-emphasis :foreground)
    :background ,(face-attribute 'mode-line :background)
    :weight bold :height 1.0 :box (:line-width -50 :color ,(face-attribute 'mode-line :background))))

(use-package! ace-window
  :config
  (setq aw-dispatch-always t)
  (after! treemacs
    (setq aw-ignored-buffers (delete 'treemacs-mode aw-ignored-buffers)))
  (ace-window-display-mode t)
  (setq aw-background nil)
  (setq aw-keys '(?n ?r ?t ?d ?u ?i ?e ?o))
  (setq aw-dispatch-alist
        ;; no docstring means dont prompt for window, use current (weird but ok)
        '((?k aw-delete-window "Delete Window")
          (?m aw-move-window "Move Window")
          (?M delete-other-windows)
          (?c aw-copy-window "Copy Window")
          (?b aw-switch-buffer-in-window "Select Buffer")
          (?a aw-flip-window)
          (?B aw-switch-buffer-other-window "Switch Buffer Other Window")
          (?s hylo/split-window-fair-and-follow)
          (?S aw-swap-window "Swap Windows")
          (?u winner-undo)
          ;; (?v aw-split-window-vert "Split Vert Window")
          ;; (?h aw-split-window-horz "Split Horz Window")
          (?v +evil/window-vsplit-and-follow)
          (?h +evil/window-split-and-follow)
          (?? aw-show-dispatch-help))))
;; windows:1 ends here

;; [[file:config.org::*mail][mail:1]]
(defadvice! go-to-workspace-if-exists-mu4e (fun)
  "Go back to the mu4e workspace if it exists, otherwise launch mu4e normally."
  :around #'=mu4e
  (run-at-time nil nil (lambda () (if (+workspace-get +mu4e-workspace-name t)
                                      (+workspace-switch +mu4e-workspace-name)
                                    (funcall fun))))
  (ignore-errors (abort-recursive-edit)))


(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

(after! mu4e-alert
  (setq +mu4e-alert-bell-cmd nil))
(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)


(defadvice! my-evil-delete-char-default-to-black-hole-a (fn beg end &optional type register)
  "Advise `evil-delete-char' to set default REGISTER to the black hole register."
  :around #'evil-delete-char
  (unless register (setq register ?_))
  (funcall fn beg end type register))

(defadvice! hy/evil-scroll-advice (fn count)
  :around #'evil-scroll-down
  :around #'evil-scroll-up
  (setq count (/ (window-body-height) 4))
  (funcall fn count))

(map! :after evil-collection :niv "C-y" #'yank)



(use-package! cape-yasnippet
  :after cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-yasnippet)
  (after! lsp-mode
    (add-hook 'lsp-managed-mode-hook #'cape-yasnippet--lsp))
  (after! eglot
    (add-hook 'eglot-managed-mode-hook #'cape-yasnippet--eglot)))



;; (use-package!)
;; (after! vterm
;;   (set-popup-rule! "^\\*vterm" :size 0.15 :side 'right :vslot -4 :select t :quit nil :ttl 0 ))
;;

;; (map!
;;  :after company
;;  :map company-active-map
;;  "RET" nil
;;  "<return>" nil
;;  [tab] #'company-complete-selection
;;  "TAB" #'company-complete-selection)



(defun my/lsp-no-code-actions ()
  (setq lsp-ui-sideline-show-code-actions nil))
(add-hook 'lsp-after-initialize-hook #'my/lsp-no-code-actions)


(defun rename-buffers-with-annoying-names ()
  (when (member (buffer-name) '("index.ts" "package.json"))
    (when (string-match "[^/]+/[^/]+$" (buffer-file-name))
      (rename-buffer (match-string 0 (buffer-file-name)) t))))

(add-hook 'change-major-mode-hook #'rename-buffers-with-annoying-names)



(setq evil-visual-update-x-selection-p t)


(setq evil-snipe-scope 'whole-buffer)





(use-package! org-super-agenda
  :commands org-super-agenda-mode
  :config
  (setq org-super-agenda-groups '(
                                  (:name "Plan"
                                   :time-grid t)

                                  (:name "Important"
                                   :priority>= "C")
                                  (:name "Scheduled"
                                   :scheduled t)
                                  (:name "Uni"
                                   ;; :face (:foreground ,(doom-color 'blue))
                                   :tag "uni")
                                  (:name "Health" :tag "health")
                                  (:name "Hobby" :tag "tech" :tag "emacs")
                                  (:name "Buy" :tag "buy")
                                  (:category "Diary" :name "Diary")
                                  (:name "Work"  ; Optionally specify section name
                                   ;; :face (:foreground ,(doom-color 'green))
                                   :order 99
                                   :tag "work"
                                   :category "work")
                                  ;; :and (:tag "work" :time-grid t))

                                  (:name "Other" :anything t))))



(setq org-agenda-custom-commands
      '(("n" "3 days and todos"
         ((agenda "" ((org-agenda-span 3)))
          (alltodo "" ((org-agenda-overriding-header "")))))))

(defadvice! my/alltodo-without-time-grid (fn &optional arg)
  "the org-super-agenda selector :time-grid t collects all TODO
items in the alltodo agenda, so we dynamically remove it when using that."
  :around #'org-todo-list
  (let ((org-super-agenda-groups (cdr org-super-agenda-groups)))
    (apply fn arg)))



(setq org-agenda-category-icon-alist
      `(
        ("uni" (#("🌳")) nil nil :ascent center)
        ;; ("work" ,(list (all-the-icons-material "work" :height 1.2 :face 'all-the-icons-green)) nil nil :ascent center)
        ("work" (#("🌸")) nil nil :ascent center)
        ("buy" (#("🪙")) nil nil :ascent center)
        ("health" (#("💊")) nil nil :ascent center)
        ("tech" (#("🦄")) nil nil :ascent center)
        ("emacs" (#("🎹")) nil nil :ascent center)
        ("chore" (#("🔱")) nil nil :ascent center)
        ;; ("" ,(list (all-the-icons-faicon "pencil" :height 1.2)) nil nil :ascent center)
        ("inbox" (#("🌊")) nil nil :ascent center)
        ("" (#("🌈")) nil nil :ascent center)))
;; mail:1 ends here

;; [[file:config.org::*workspaces][workspaces:1]]
(custom-set-faces!
  '(+workspace-tab-face :inherit default :family "Jost*" :height 135)
  '(+workspace-tab-selected-face :inherit (highlight +workspace-tab-face)))
(after! persp-mode
  (defun workspaces-formatted ()
    (+doom-dashboard--center (frame-width)
                             (let ((names (or persp-names-cache nil))
                                   (current-name (safe-persp-name (get-current-persp))))
                               (mapconcat
                                #'identity
                                (cl-loop for name in names
                                         for i to (length names)
                                         collect
                                         (concat (propertize (format " %d" (1+ i)) 'face
                                                             `(:inherit ,(if (equal current-name name)
                                                                             '+workspace-tab-selected-face
                                                                           '+workspace-tab-face)
                                                               :weight bold))
                                                 (propertize (format " %s " name) 'face
                                                             (if (equal current-name name)
                                                                 '+workspace-tab-selected-face
                                                               '+workspace-tab-face))))
                                " "))))

  (defun hy/invisible-current-workspace ()
    "The tab bar doesn't update when only faces change (i.e. the
current workspace), so we invisibly print the current workspace
name as well to trigger updates"
    (propertize (safe-persp-name(get-current-persp)) 'invisible t))
  ;; (safe-persp-name(get-current-persp)))

  (customize-set-variable 'tab-bar-format '(workspaces-formatted tab-bar-format-align-right hy/invisible-current-workspace))

  ;; don't show current workspaces when we switch, since we always see them
  (advice-add #'+workspace/display :override #'ignore)
  ;; same for renaming and deleting (and saving, but oh well)
  (advice-add #'+workspace-message :override #'ignore))

;; (customize-set-variable 'tab-bar-mode t)


;; need to run this later for it to not break frame size for some reason
  (run-at-time nil nil (cmd! (tab-bar-mode +1)))
;; workspaces:1 ends here
