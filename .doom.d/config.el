;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
(setq doom-font (font-spec :family "Fira Code" :size 26)
      doom-variable-pitch-font (font-spec :family "Jost*" :size 30))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme (seq-random-elt (custom-available-themes)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq which-key-idle-delay 0.3)
(setq evil-snipe-scope 'visible)

(map! :n "C-+" #'doom/increase-font-size)
(map! :n "C-=" #'doom/reset-font-size)
(map! :n "C--" #'doom/decrease-font-size)

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
(setq lsp-auto-guess-root t)

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

(map! :leader
      :desc "Magit push"    
      "g p" #'magit-push)

(map! :map org-mode-map
      :after org
      :localleader
      "a" #'org-archive-subtree
        (:prefix ("A" . "attachments")
         "a" #'org-attach
         "d" #'org-attach-delete-one
         "D" #'org-attach-delete-all
         "f" #'+org/find-file-in-attachments
         "l" #'+org/attach-file-and-insert-link
         "n" #'org-attach-new
         "o" #'org-attach-open
         "O" #'org-attach-open-in-emacs
         "r" #'org-attach-reveal
         "R" #'org-attach-reveal-in-emacs
         "u" #'org-attach-url
         "s" #'org-attach-set-directory
         "S" #'org-attach-sync
         (:when (featurep! +dragndrop)
          "c" #'org-download-screenshot
          "p" #'org-download-clipboard
          "P" #'org-download-yank)))

(map! :map evil-window-map
      "<left>" #'evil-window-left
      "<down>" #'evil-window-down
      "<up>" #'evil-window-up
      "<right>" #'evil-window-right

      "S-<left>" #'+evil/window-move-left
      "S-<down>" #'+evil/window-move-down
      "S-<up>" #'+evil/window-move-up
      "S-<right>" #'+evil/window-move-right

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


(load! "load/vue-polymode.el")
(load! "load/mail.el")
(load! "load/dotfiles.el")
(load! "load/format-classes.el")
