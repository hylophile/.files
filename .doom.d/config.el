;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(load! "load/maps.el")
;; (map! :n "C-+" #'text-scale-increase)
;; (map! :n "C--" #'text-scale-decrease)
;; (map! :i "C-x C-s" #'save-buffer)

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; (map! :n "e" #'ediff-current-file)

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

;;; hr
(setq projectile-project-search-path '("~/code" "~/tub"))

(defun mu5e ()
  (interactive)
  (run-at-time nil nil (lambda () (if (+workspace-get +mu4e-workspace-name t)
                                      (+workspace-switch +mu4e-workspace-name)
                                    (=mu4e))))
  (ignore-errors (abort-recursive-edit)))

(defadvice! yeet+hylo/go-to-workspace-if-exists-mu4e (fun)
  "Go back to the mu4e workspace if it exists, otherwise launch mu4e normally."
  :around #'=mu4e
  (run-at-time nil nil (lambda () (if (+workspace-get +mu4e-workspace-name t)
                                      (+workspace-switch +mu4e-workspace-name)
                                    (funcall fun))))
  (ignore-errors (abort-recursive-edit)))


;; (map! :leader "o m" #'mu5e)

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

(after! mu4e-alert
  (setq +mu4e-alert-bell-cmd nil))
;; (setq auth-sources '("~/.authinfo.gpg")
;;       auth-source-cache-expiry nil)
(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)
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
 doom-font (font-spec :family "Fira Code" :size 10.0)
 ;; doom-font (font-spec :family "JuliaMono" :size 10.0)
 ;; doom-font (font-spec :family "JuliaMono" :size 10.0)
 ;; doom-font (font-spec :family "JetBrains Mono" :size 11.0)
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

;; (setq doom-theme 'everforest-harder)
;; (setq doom-theme (hylo/random-dark-theme))
(setq doom-theme 'ef-spring)
;; (setq doom-theme 'doom-dracula)


;;
;; (setq +doom-dashboard-functions (append
;;                                  (list (car +doom-dashboard-functions))
;;                                  '(hylo/insert-theme)
;;                                  (cdr +doom-dashboard-functions)))

;; tokyo night is nice
;;
(use-package! cape-yasnippet
  :after cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-yasnippet)
  (after! lsp-mode
    (add-hook 'lsp-managed-mode-hook #'cape-yasnippet--lsp))
  (after! eglot
    (add-hook 'eglot-managed-mode-hook #'cape-yasnippet--eglot)))

(setq doom-themes-treemacs-theme "doom-colors")


(setq vterm-always-compile-module t)
;; (use-package!)
;; (after! vterm
;;   (set-popup-rule! "^\\*vterm" :size 0.15 :side 'right :vslot -4 :select t :quit nil :ttl 0 ))
;;
(defun my/ef-themes-custom-faces ()
  (interactive)
  (when (string-prefix-p "ef-" (symbol-name doom-theme))
    ;; (require 'ef-light)
    (custom-set-faces
     `(solaire-default-face ((,c :inherit default :background ,bg-alt :foreground ,fg-dim)))
     `(solaire-line-number-face ((,c :inherit solaire-default-face :foreground ,fg-dim)))
     `(solaire-hl-line-face ((,c :background ,bg-active)))
     `(solaire-org-hide-face ((,c :background ,bg-alt :foreground ,bg-alt))))))

                                        ;(add-hook 'doom-load-theme-hook #'my/ef-themes-custom-faces)


;; ef-themes-post-load-hook

;; (map!
;;  :after company
;;  :map company-active-map
;;  "RET" nil
;;  "<return>" nil
;;  [tab] #'company-complete-selection
;;  "TAB" #'company-complete-selection)

;; (custom-set-faces! '((flycheck-fringe-error) :width expanded))


(defun my/lsp-no-code-actions ()
  (setq lsp-ui-sideline-show-code-actions nil))
(add-hook 'lsp-after-initialize-hook #'my/lsp-no-code-actions)

;; (after! magit
;;   (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; (defun six-split-window ()
;;   (interactive)
;;   (split-window-right)
;;   (split-window-right)
;;   (split-window-below)
;;   (other-window 2)
;;   (split-window-below)
;;   (other-window 2)
;;   (split-window-below))




(defun rename-buffers-with-annoying-names ()
  (when (member (buffer-name) '("index.ts" "package.json"))
    (when (string-match "[^/]+/[^/]+$" (buffer-file-name))
      (rename-buffer (match-string 0 (buffer-file-name)) t))))

(add-hook 'change-major-mode-hook #'rename-buffers-with-annoying-names)

(setq evil-visual-update-x-selection-p t)

(map! :map org-mode-map
      :leader
      "d" (cmd! (org-todo "DONE"))
      "D" #'org-archive-done-tasks)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq which-key-idle-delay 0.3)
(setq evil-snipe-scope 'whole-buffer)

;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(map! :leader :desc "Actions" "e" #'embark-act)
(map! :leader
      "a" #'ace-window)

(defun hylo/split-window-fair-and-follow ()
  "Split current window vertically or horizontally, based on its current dimensions.
Use evil's window splitting function to follow into the new window."
  (let* ((window (selected-window))
         (w (window-body-width window))
         (h (window-body-height window)))
    (if (< (* h 2.2) w)
        (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
          (call-interactively #'evil-window-vsplit))
      (let ((evil-split-window-below (not evil-split-window-below)))
        (call-interactively #'evil-window-split)))))

(map! :map evil-window-map "s" #'hylo/split-window-fair-and-follow)



;; (map! :nmv [C-i] #'evil-forward-WORD-end)

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

(use-package! avy
  :config
  (setq avy-all-windows t))

(setq dired-dwim-target t)
(setq org-agenda-mouse-1-follows-link t)
(setq org-tags-column 0)
(setq org-agenda-tags-column 0)

;; (setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))
(setq org-agenda-files '("~/org" "~/org/issues"))
;; (custom-set-faces! '(org-agenda-calendar-event :family "Victor Mono"))
;; (custom-set-faces! '(font-lock-comment-face :slant italic :weight semi-bold :family "Victor Mono" :height 0.98))
;; (setq doom-dracula-colorful-headers t)
(setq org-cycle-max-level 5)

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

;; (after! csharp-mode
;;   (remove-hook 'csharp-mode-hook #'rainbow-delimiters-mode))


(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'file))

;; (setq my/blue (doom-color 'blue))
;; (setq org-tag-faces
;;       `(
;; ("uni" . (:foreground ,(doom-color 'blue) :weight bold))
;; ("work" . (:foreground my/blue))
;; ("work"  . (:foreground "med"))
;; ))
;; (setq org-tag-faces

;;       '(

;;         ("work"  . (:foreground "mediumPurple1" :weight bold))

;;         ("uni"   . (:foreground "royalblue1"    :weight bold))

;;         ("frontend"  . (:foreground "forest green"  :weight bold))

;;         ("QA"        . (:foreground "sienna"        :weight bold))

;;         ("meeting"   . (:foreground "yellow1"       :weight bold))

;;         ("CRITICAL"  . (:foreground "red1"          :weight bold))

;;         )

;;       )



;; (let ((org-super-agenda-groups
;;        '(;; Each group has an implicit boolean OR operator between its selectors.
;;          (:name "Uni"  ; Optionally specify section name
;;           :time-grid t  ; Items that appear on the time grid
;;           :tag "uni")  ; Items that have this TODO keyword
;;          (:name "Work"  ; Optionally specify section name
;;           ;; :time-grid t  ; Items that appear on the time grid
;;           :tag "work")  ; Items that have this TODO keyword
;;          (:name "Important"
;;           ;; Single arguments given alone
;;           :tag "bills"
;;           :priority "A")
;;          ;; Set order of multiple groups at once
;;          (:order-multi (2 (:name "Shopping in town"
;;                            ;; Boolean AND group matches items that match all subgroups
;;                            :and (:tag "shopping" :tag "@town"))
;;                           (:name "Food-related"
;;                            ;; Multiple args given in list with implicit OR
;;                            :tag ("food" "dinner"))
;;                           (:name "Personal"
;;                            :habit t
;;                            :tag "personal")
;;                           (:name "Space-related (non-moon-or-planet-related)"
;;                            ;; Regexps match case-insensitively on the entire entry
;;                            :and (:regexp ("space" "NASA")
;;                                  ;; Boolean NOT also has implicit OR between selectors
;;                                  :not (:regexp "moon" :tag "planet")))))
;;          ;; Groups supply their own section names when none are given
;;          (:todo "WAITING" :order 8)  ; Set order of this section
;;          (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
;;           ;; Show this group at the end of the agenda (since it has the
;;           ;; highest number). If you specified this group last, items
;;           ;; with these todo keywords that e.g. have priority A would be
;;           ;; displayed in that group instead, because items are grouped
;;           ;; out in the order the groups are listed.
;;           :order 9)
;;          (:priority<= "B"
;;           ;; Show this section after "Today" and "Important", because
;;           ;; their order is unspecified, defaulting to 0. Sections
;;           ;; are displayed lowest-number-first.
;;           :order 1)
;;          ;; After the last group, the agenda will display items that didn't
;;          ;; match any of these groups, with the default order position of 99
;;          )))
;;   (org-agenda nil "a"))
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
;; (setq org-agenda-prefix-format "  %?-12t% s")
;; (setq org-agenda-prefix-format
;;       '((agenda . " %-12:c%?-12t% s")
;;         (todo . " %i %-12:c")
;;         (tags . " %i %-12:c")
;;         (search . " %i %-12:c")))


(after! org-agenda
  (org-super-agenda-mode))

;; (setq org-superstar-headline-bullets-list '(9678 9673 9675))
;; (setq org-superstar-headline-bullets-list '(9689))
(setq org-superstar-headline-bullets-list "●⚬")

(use-package! mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode)
  )



;; (after! mixed-pitch
;;   (setq mixed-pitch-face 'variable-pitch-bigger)
;;   )

;; (defface variable-pitch-bigger
;;   '((t (:family "Overpass" :size 40)))
;;   "Face for mixed-pitch mode"
;;   :group 'basic-faces)
;; (defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
;;   "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
;; (defun init-mixed-pitch-h ()
;;   "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
;; Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
;;   (when (memq major-mode mixed-pitch-modes)
;;     (mixed-pitch-mode 1))
;;   (dolist (hook mixed-pitch-modes)
;;     (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
;; (add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

;; (add-hook! org-mode (display-line-numbers-mode -1))

(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)

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



(setq org-agenda-format-date (lambda (date) (concat "\n"
                                                    ;; (make-string (window-width) 9472)
                                                    ;; "\n"
                                                    (org-agenda-format-date-aligned date))))

(after! org
  (setq org-agenda-start-day "0d"
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-timestamp-if-done t))
;; org-agenda-todo-ignore-with-date t


;; (push 'habits org-modules)

;; (defun my/todo-org-is-unreal (buf)
;;       (string= (buffer-name buf) "todo.org"))
;; (push #'my/todo-org-is-unreal doom-unreal-buffer-functions)

(defadvice! hy/center-line-after-search (&rest _)
  :after #'evil-ex-search-next
  :after #'evil-ex-search-previous
  (evil-scroll-line-to-center nil))

(setq find-file-visit-truename nil)
(setq find-file-existing-other-name nil)

;; (use-package! org
;;   :config
;;   (require 'org-habit))

(custom-set-faces!
  '(org-document-title :height 1.1))
(custom-set-faces!
  `(org-agenda-diary :foreground ,(doom-color 'magenta) :weight bold))

(map! :after evil :nv "'" #'evil-goto-mark)

;; (setq projectile-project-search-path '("~/code"))
;; (after! (company org)
;; (set-company-backend! 'org-mode nil))
;; (map! "M-SPC" #'doom/leader)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (setq lsp-auto-guess-root t)
(setq iedit-toggle-key-default nil)
(map! :localleader :map org-mode-map "~" (cmd! (org-toggle-checkbox '(16))))
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




(setq +format-with-lsp nil)
;; (setq +format-on-save-enabled-modes
;; '(not sgml-mode))
;; '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
;;       sql-mode         ; sqlformat is currently broken
;;       tex-mode         ; latexindent is broken
;;       latex-mode))
;; (setq-hook! 'sgml-mode +format-with-lsp t)
;; (setq-hook! 'html-mode +format-with-lsp t)
(after! company
  (setq +company-backend-alist
        '((text-mode (:separate company-dabbrev company-yasnippet))
          (prog-mode company-capf company-yasnippet)
          (conf-mode company-capf company-dabbrev-code company-yasnippet))))

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

;; (map! :g "C-t" #'+vterm/toggle)


;;; Workspaces tab bar


(custom-set-faces!
  '(+workspace-tab-face :inherit default :family "Jost*" :height 135)
  '(+workspace-tab-selected-face :inherit (highlight +workspace-tab-face)))
(after! persp-mode
  (defun left-right-center (len l c r)
    "Xa "
    (let* ((space-left (ceiling (max 0 (- len (length c) (* 2 (length l)))) 2))
           (space-right (- len (+ (length l) (length c) space-left) (length r))))
      (concat
       l
       (make-string space-left ? )
       c
       (make-string space-right ? )
       r)))

  (left-right-center 40 "abc" "arst" "ghi")

  (defun lcr (l c r)
    (left-right-center (frame-width) l c r))

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

  ;; (defun +workspace--tabline () ())
  ;; (defun wsf ()
  ;;   (lcr "eloariiiiiiiiiiiiiiiiiiiiiiiiiiiiiistoienarstoyulwfp"
  ;;        (+workspace--tabline)
  ;;   (hy/invisible-current-workspace)

  ;;        )
  ;;  )

  ;; (wsf)

  (defun hy/invisible-current-workspace ()
    "The tab bar doesn't update when only faces change (i.e. the
current workspace), so we invisibly print the current workspace
name as well to trigger updates"
    (propertize (safe-persp-name(get-current-persp)) 'invisible t))
  ;; (safe-persp-name(get-current-persp)))

  (customize-set-variable 'tab-bar-format '(workspaces-formatted tab-bar-format-align-right hy/invisible-current-workspace))
  ;;  (customize-set-variable 'tab-bar-format '(wsf))
  ;; (customize-set-variable 'tab-bar-format '(+workspace--tabline tab-bar-format-align-right hy/invisible-current-workspace))

  ;; don't show current workspaces when we switch, since we always see them
  (advice-add #'+workspace/display :override #'ignore)
  ;; same for renaming and deleting (and saving, but oh well)
  (advice-add #'+workspace-message :override #'ignore))

(customize-set-variable 'tab-bar-mode t)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:/]?\\(?:a-\\)?\\(.*\\)") . (nil . "ຯ\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "ຯ\\1"))))

;; (after! persp-mode
;; (remove-hook! 'after-make-frame-functions #'persp-init-new-frame)
;; (remove-hook! 'after-make-frame-functions 'persp-init-new-frame)
;; )
;; (setq persp-init-frame-behaviour -1)

(setq
 window-divider-default-bottom-width 1
 window-divider-default-right-width 5)
;; (defadvice! wider-frame-dividers (w)
;;   :filter-return window-right-divider-width
;;   (* w 10))
;;

(setq org-archive-location "~/org/archive/%s_archive::")

(defadvice! my/hide-archived-on-global-cycle (&rest _)
  "For some reason org-content (i.e. <number>S-<TAB>) does not
respect the hidden status of archived headings and shows them.
This hides them again."
  :after #'org-content
  (org-hide-archived-subtrees (point-min) (point-max)))

;; (add-hook 'org-cycle (cmd! (org-hide-archived-subtrees (point-min) (point-max))))

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

;;(use-package! prism :config (prism-set-colors :colors (-map #'doom-color '(red orange yellow green blue violet))))
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


;; (load! "load/vue-polymode.el")

;; (global-subword-mode t)                           ; Iterate through CamelCase words

;; (setq +format-on-save-enabled-modes
;; '(not sgml-mode))
;; '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
;;       sql-mode         ; sqlformat is currently broken
;;       tex-mode         ; latexindent is broken
;;       latex-mode))
;; (setq-hook! 'sgml-mode +format-with-lsp t)
;; (setq-hook! 'html-mode +format-with-lsp t)

(setq org-agenda-format-date (lambda (date) (concat "\n"
                                                    (make-string (window-width) 9472)
                                                    "\n"
                                                    (org-agenda-format-date-aligned date))))
;;(use-package! prism :config (prism-set-colors :colors (-map #'doom-color '(red orange yellow green blue violet))))

;; (add-hook 'org-mode-hook #'+org-pretty-mode)

;; (remove-hook 'doom-first-buffer-hook 'smartparens-global-mode)
;; (remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(setq evil-disable-insert-mode-bindings t)
(setq doom-modeline-modal-icon nil)

(use-package! svelte-mode)

(use-package! svelte-mode)

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



;; no rainbow-delimiters
;; (add-hook 'after-change-major-mode-hook (cmd! (rainbow-delimiters-mode -1)))

;; (cl-defun +vertico-elisp-search (&key query in all-files (recursive t) prompt args)
;;   "Conduct a file search using ripgrep.

;; :query STRING
;;   Determines the initial input to search for.
;; :in PATH
;;   Sets what directory to base the search out of. Defaults to the current project's root.
;; :recursive BOOL
;;   Whether or not to search files recursively from the base directory."
;;   (declare (indent defun))
;;   (interactive)
;;   (unless (executable-find "rg")
;;     (user-error "Couldn't find ripgrep in your PATH"))
;;   (require 'consult)
;;   (setq deactivate-mark t)
;;   (let* ((project-root (or (doom-project-root) default-directory))
;;          (directory (or in project-root))
;;          (consult-ripgrep-args
;;           (concat "rg "
;;                   (if all-files "-uu ")
;;                   (unless recursive "--maxdepth 1 ")
;;                   "--line-buffered --search-zip --color=never --max-columns=1000 "
;;                   "--path-separator /   --smart-case --no-heading --line-number "
;;                   "--hidden -g !.git -g elisp.info.gz "
;;                   (mapconcat #'shell-quote-argument args " ")
;;                   "."))
;;          (prompt (if (stringp prompt) (string-trim prompt) "Search"))
;;          (query (or query
;;                     (when (doom-region-active-p)
;;                       (regexp-quote (doom-thing-at-point-or-region)))))
;;          (consult-async-split-style consult-async-split-style)
;;          (consult-async-split-styles-alist consult-async-split-styles-alist))
;;     ;; Change the split style if the initial query contains the separator.
;;     (when query
;;       (cl-destructuring-bind (&key type separator initial)
;;           (consult--async-split-style)
;;         (pcase type
;;           (`separator
;;            (replace-regexp-in-string (regexp-quote (char-to-string separator))
;;                                      (concat "\\" (char-to-string separator))
;;                                      query t t))
;;           (`perl
;;            (when (string-match-p initial query)
;;              (setf (alist-get 'perlalt consult-async-split-styles-alist)
;;                    `(:initial ,(or (cl-loop for char in (list "%" "@" "!" "&" "/" ";")
;;                                             unless (string-match-p char query)
;;                                             return char)
;;                                    "%")
;;                      :type perl)
;;                    consult-async-split-style 'perlalt))))))
;;     (consult--grep prompt #'consult--ripgrep-builder "/usr/share/info" query)))



;; (use-package! vue-mode)


(defun my/info-buffer-p (buf)
  (string= (buffer-name buf) "*info*"))
(push 'my/info-buffer-p doom-real-buffer-functions)

(defun my/helpful-buffer-p (buf)
  (string-prefix-p "*helpful" (buffer-name buf)))
(push 'my/helpful-buffer-p doom-real-buffer-functions)

(defun my/search-info-org ()
  (interactive)
  (info "org")
  (+popup/raise (selected-window))
  (+default/search-buffer))
(defun my/search-info-elisp ()
  (interactive)
  (info "elisp")
  (+popup/raise (selected-window))
  (+default/search-buffer))
(defun my/search-emacsd ()
  (interactive)
  (+vertico/project-search t nil "~/.emacs.d"))
(map! :leader :prefix "s"
      ;; "e" #'my/search-emacsd
      "E" #'my/search-info-elisp
      "n" #'my/search-info-org)

(setq
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…")


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

(setq confirm-kill-emacs nil)

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
;; (advice-remove 'my/workspace-buffer-list-without-vterm #'+workspace-buffer-list)
;; (map! :map smartparens-mode-map
;;      [C-right] #'sp-wrap-round)
;; (define-minor-mode my-minor-mode
;;   "My minor mode"
;;   :init-value t)
;; (use-package! ein
;;   ;; :hook ((symbol ein:markdown-mode) . #'enable-minor-modes-in-poly-mode-h)
;;   ;; :hook (python-mode . #'enable-minor-modes-in-poly-mode-h)
;;   ;; :hook (fundamental-mode . #'enable-minor-modes-in-poly-mode-h)
;;   :config
;;   (defun ein-buffer-p (buf)
;;     (string-match-p ".*\\*ein:.*" (buffer-name buf)))
;;   (defun ein-variable ()
;;     (interactive)
;;     (when (ein-buffer-p (current-buffer))
;;       (let* ((overlays (overlays-in (point-min) (point-max)))
;;              ;; (input-overlays (seq-filter (lambda (x) (string= "ein:cell-input-area" (overlay-get x 'face)))
;;              ;; (overlays-in (point-min) (point-max))))
;;              (input-overlays (seq-filter (lambda (x) (string= "ein:cell-output-area" (overlay-get x 'face)))
;;                                          (overlays-in (point-min) (point-max))))
;;              (non-md-overlays (seq-remove (lambda (x) (string= "ein:markdown-mode"
;;                                                                (get-text-property (overlay-start x) :pm-mode)))
;;                                           overlays)))
;;         (message (format "%s" non-md-overlays))
;;         (message "setting faces")
;;         (mapcar (lambda (ovl) (unless (listp (overlay-get ovl 'face))
;;                                 (overlay-put ovl 'face `(,(overlay-get ovl 'face) org-block))))
;;                 non-md-overlays)
;;         )))
;;   (defun ein-wait-time ()
;;     (run-at-time 2.0 nil
;;                  #'ein-variable))
;;   ;; (defadvice! after-ein-notebook-open--callback (&rest _)
;;   ;;   :after #'ein:notebook-open--callback
;;   ;;     (enable-minor-modes-in-poly-mode-h)
;;   ;;     (ein-wait-time))
;;   ;; (add-hook! doom-switch-buffer-hook #'ein-variable)
;;   (defun enable-minor-modes-in-poly-mode-h ()
;;     (message "enabling minor poly stuff")
;;     (when (ein-buffer-p (current-buffer))
;;       ;; (undo-fu-mode -1)
;;       (visual-line-mode +1)
;;       (mixed-pitch-mode +1)
;;       (display-line-numbers-mode +1)))

;;   (set-popup-rule! "^.*\\*ein:notebooklist.*"
;;     :size 0.3
;;     :side 'bottom
;;     :quit 't)

;;   (after! link-hint
;;     (link-hint-define-type 'ein-notebooklist
;;       :next #'link-hint--next-widget-button
;;       :at-point-p #'link-hint--widget-button-at-point-p
;;       :vars '(ein:notebooklist-mode)
;;       :open #'widget-button-press)
;;     (push 'link-hint-ein-notebooklist link-hint-types))


;;   ;; (defadvice! disable-undo-fu (&rest)
;;   ;;   )
;;   ;; (add-hook!
;;   ;; '(fundamental-mode-hook ein:markdown-mode-hook python-mode-hook)
;;   ;; poly-ein-mode #'enable-minor-modes-in-poly-mode-h #'ein-variable)
;;   (add-hook! poly-ein-mode #'enable-minor-modes-in-poly-mode-h #'ein-wait-time)

;;   (defadvice! center-after-cell-move (orig-fun &rest args)
;;     :after 'ein:worksheet-goto-next-input
;;     :after 'ein:worksheet-goto-prev-input
;;     ;; (evil-scroll-line-to-center (line-number-at-pos))
;;     ;; (let ((current-window (get-buffer-window)))
;;     ;;   (apply orig-fun args)
;;     ;;   (with-selected-window current-window (recenter))))
;;     (run-at-time 0.01 nil #'recenter))

;;   (map! :localleader
;;         :map poly-ein-mode-map
;;         "n" #'ein:worksheet-goto-next-input-km
;;         "p" #'ein:worksheet-goto-prev-input-km)
;;   (defhydra +hydra/ein (:color blue)
;;     "
;;           Cell navigation: _n_ext  _p_revious
;; "
;;     ("n" ein:worksheet-goto-next-input-km)
;;     ("p" ein:worksheet-goto-prev-input-km))

;;   (pushnew! mixed-pitch-fixed-pitch-faces
;;             'ein:notification-tab-normal 'ein:cell-input-prompt 'ein:cell-output-area))
;; (custom-set-faces!
;;   ;; `(ein:cell-input-area :background ,(doom-color 'base3))
;;   ;; `(ein:cell-input-area :inherit (org-block))
;;   `(ein:cell-input-area :background ,(face-attribute 'org-block :background))))

(delete "Noto Color Emoji" doom-emoji-fallback-font-families)

(defun my/lsp-no-code-actions ()
  (setq lsp-ui-sideline-show-code-actions nil))
(add-hook 'lsp-after-initialize-hook #'my/lsp-no-code-actions)

(defun rc/find-file-recursive ()
  (interactive)
  (let* ((cwd (file-name-directory (buffer-file-name)))
         (files (directory-files-recursively cwd ""))
         (files-without-cwd (mapcar (lambda (f) (string-remove-prefix cwd f)) files)))
    (find-file (completing-read (format "Find file [%s]: " cwd) files-without-cwd nil t))))

;; (use-package! org-modern
;;   :hook (org-mode . org-modern-mode)
;;   :hook (org-agenda-finalize . org-modern-agenda))

(use-package! lsp-volar)
;; (load! "load/vue-polymode.el")
;; (load! "load/vue-polymode.el")
;; (use-package! vue-mode
;;   :hook (vue-mode . lsp-deferred))
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


;; (defun my-open-calendar ()
;;   (interactive)
;;   (cfw:open-calendar-buffer
;;    :contents-sources
;;    (list
;;     (cfw:org-create-source (doom-color 'blue))  ; org-agenda source
;;     ;; (cfw:org-create-file-source "cal" "/path/to/cal.org" "Cyan")  ; other org source
;;     ;; (cfw:howm-create-source "Blue")  ; howm source
;;     ;; (cfw:cal-create-source "Orange") ; diary source
;;     ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
;;     ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
;;     )))

(remove-hook! 'doom-modeline-mode-hook #'size-indication-mode)

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

;; (setq doom-localleader-key "\\")

;; (map! :leader :map org-mode-map "c f" (cmd!! #'unpackaged/org-fix-blank-lines t))


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

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

(use-package! apheleia
  :config
  (apheleia-global-mode +1))

(use-package! ef-themes
  :defer nil)


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
  (setq company-idle-delay nil))

(setq evil-ex-substitute-global t)

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))
