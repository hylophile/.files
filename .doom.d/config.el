;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(load! "load/maps.el")
;; (map! :n "C-+" #'text-scale-increase)
;; (map! :n "C--" #'text-scale-decrease)
;; (map! :i "C-x C-s" #'save-buffer)

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "name"
      user-mail-address "mail")

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
(setq doom-font (font-spec :family "Fira Code" :size 12.0)
      ;; doom-variable-pitch-font (font-spec :family "Jost*" :size 30)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 12.0))
(setq doom-font-increment 1)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(defadvice! my-evil-delete-char-default-to-black-hole-a (fn beg end &optional type register)
  "Advise `evil-delete-char' to set default REGISTER to the black hole register."
  :around #'evil-delete-char
  (unless register (setq register ?_))
  (funcall fn beg end type register))

(defadvice! my/evil-scroll-advice (fn count)
  ""
  :around #'evil-scroll-down
  :around #'evil-scroll-up
  (setq count (/ (window-body-height) 6))
  (funcall fn count))


(setq doom-theme (hylo/random-dark-theme))
(setq +doom-dashboard-functions (append
                                 (list (car +doom-dashboard-functions))
                                 '(hylo/insert-theme)
                                 (cdr +doom-dashboard-functions)))

(setq doom-themes-treemacs-theme "doom-colors")

;; (after! vterm
;;   (set-popup-rule! "^\\*vterm" :size 0.15 :side 'right :vslot -4 :select t :quit nil :ttl 0 ))

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

(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq which-key-idle-delay 0.3)
(setq evil-snipe-scope 'visible)

(map! :leader :desc "Actions" "e" #'embark-act)
(map! :leader
      "a" #'ace-window)

(defun hylo/aw-split-window-fair-and-follow ()
  "Split WINDOW vertically or horizontally, based on its current dimensions.
Modify `aw-fair-aspect-ratio' to tweak behavior.
Use evil's window splitting function to follow into the new window."
  (let* ((window (selected-window))
         (w (window-body-width window))
         (h (window-body-height window)))
    (if (< (* h 2.2) w)
        (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
          (call-interactively #'evil-window-vsplit))
      (let ((evil-split-window-below (not evil-split-window-below)))
        (call-interactively #'evil-window-split)))))

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
          (?s hylo/aw-split-window-fair-and-follow)
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

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  )
(after! mixed-pitch
  (setq mixed-pitch-face 'variable-pitch-bigger)
  )

(defface variable-pitch-bigger
  '((t (:family "Overpass" :size 40)))
  "Face for mixed-pitch mode"
  :group 'basic-faces)

;; (push 'org-todo-keyword-faces permanently-enabled-local-variables)

(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)


(custom-set-faces!
  '(outline-1 :weight semi-bold :height 1.15)
  '(outline-2 :weight semi-bold :height 1.10)
  '(outline-3 :weight semi-bold :height 1.09)
  '(outline-4 :weight semi-bold :height 1.06)
  '(outline-5 :weight semi-bold :height 1.03)
  '(outline-6 :weight semi-bold :height 1.00)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.5))


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

(setq auth-sources '("~/.authinfo"))
(after! forge
  (setq forge-add-pullreq-refspec nil)
  (add-to-list 'forge-alist
               '("gitlab.employer"
                 "gitlab.employer/api/v4"
                 "gitlab.employer" forge-gitlab-repository)))

(setq avy-keys '(?s ?n ?r ?t ?d ?y))

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
      scroll-margin 2
      hscroll-margin 10)                            ; It's nice to maintain a little margin

(global-subword-mode t)                           ; Iterate through CamelCase words

;; (setq +format-on-save-enabled-modes
;; '(not sgml-mode))
;; '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
;;       sql-mode         ; sqlformat is currently broken
;;       tex-mode         ; latexindent is broken
;;       latex-mode))
;; (setq-hook! 'sgml-mode +format-with-lsp t)
;; (setq-hook! 'html-mode +format-with-lsp t)

(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      ;; (insert (+workspace--tabline))
      (insert (format
               (format "%%s %%%ds"
                       (- (frame-width)
                          (length (+workspace--tabline))
                          1))
               (+workspace--tabline)
               (propertize
                (symbol-name doom-theme)
                'face '(:inherit (mode-line-emphasis)))))))

  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

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

(global-subword-mode t)                           ; Iterate through CamelCase words

;; (setq +format-on-save-enabled-modes
;; '(not sgml-mode))
;; '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
;;       sql-mode         ; sqlformat is currently broken
;;       tex-mode         ; latexindent is broken
;;       latex-mode))
;; (setq-hook! 'sgml-mode +format-with-lsp t)
;; (setq-hook! 'html-mode +format-with-lsp t)


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


(add-hook 'org-mode-hook #'+org-pretty-mode)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t)
  :config
  (push 'vue-mode lsp-tailwindcss-major-modes)
  )

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
      "e" #'my/search-emacsd
      "E" #'my/search-info-elisp
      "n" #'my/search-info-org)

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




(defun my/lsp-no-code-actions ()
  (setq lsp-ui-sideline-show-code-actions nil))
(add-hook 'lsp-after-initialize-hook #'my/lsp-no-code-actions)



(load! "load/vue-polymode.el")
(load! "load/mail.el")
(load! "load/dotfiles.el")
(load! "load/format-classes.el")
