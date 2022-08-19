;;; everforest-harder-theme.el --- Everforest Hard Dark Theme

;; Copyright 2022 Evan Sarris

;; Author: Jonathan Chu <evan@theoryware.net>
;; URL: https://git.sr.ht/~theorytoe/everforest-harder-theme
;; Version: 0.0.1

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License v3.0 for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; An Emacs port of the Everforest Vim Theme
;; This is a current work in progress, so expect issues and unorthodox behavior
;; 256-colors are currently supported, but not extensively tested, and may
;; behave unexpectedly

;;; Code:

(deftheme everforest-harder
  "Everforest Hard Dark - sainnhe/everforest hard dark port to emacs")

(defvar everforest-harder-colors-alist
  (let* ((256color  (eq (display-color-cells (selected-frame)) 256))
         (colors `(("everforest-harder-accent"   . "#a7c080")
                   ("everforest-harder-fg"       . (if ,256color "color-150" "#d3c6aa"))
                   ("everforest-harder-bg"       . (if ,256color "color-239" "#1b2222"))
                   ("everforest-harder-bg-1"     . (if ,256color "color-234" "#121417"))
                   ("everforest-harder-bg-hl"    . (if ,256color "color-240" "#252c2c"))
                   ("everforest-harder-gutter"   . (if ,256color "color-241" "#445055"))
                   ("everforest-harder-mono-1"   . (if ,256color "color-248" "#ABB2BF"))
                   ("everforest-harder-mono-2"   . (if ,256color "color-240" "#503946"))
                   ("everforest-harder-mono-3"   . (if ,256color "color-244" "#859289"))
                   ("everforest-harder-cyan"     . "#83c092")
                   ("everforest-harder-blue"     . "#7fbbb3")
                   ("everforest-harder-purple"   . "#d699b6")
                   ("everforest-harder-green"    . "#a7c080")
                   ("everforest-harder-red-1"    . "#e67e80")
                   ("everforest-harder-red-2"    . "#e67e80")
                   ("everforest-harder-orange-1" . "#e69875")
                   ("everforest-harder-orange-2" . "#ddbc7f")
                   ("everforest-harder-gray"     . (if ,256color "color-240" "#252c2c"))
                   ("everforest-harder-silver"   . (if ,256color "color-247" "#9da9a0"))
                   ("everforest-harder-black"    . (if ,256color "color-239" "#1b2222"))
                   ("everforest-harder-border"   . (if ,256color "color-232" "#445055")))))
    colors)
  "List of Everforest Hard Dark Dark colors.")

(defmacro everforest-harder-with-color-variables (&rest body)
  "Bind the colors list around BODY."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@ (mapcar (lambda (cons)
                      (list (intern (car cons)) (cdr cons)))
                    everforest-harder-colors-alist))
     ,@body))

(everforest-harder-with-color-variables
  (custom-theme-set-faces
   'everforest-harder

   `(default             ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg))))
   `(success             ((t (:foreground ,everforest-harder-green))))
   `(warning             ((t (:foreground ,everforest-harder-orange-2))))
   `(error               ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(link                ((t (:foreground ,everforest-harder-blue :underline t :weight bold))))
   `(link-visited        ((t (:foreground ,everforest-harder-blue :underline t :weight normal))))
   `(cursor              ((t (:background ,everforest-harder-fg))))
   `(fringe              ((t (:background ,everforest-harder-bg))))
   `(region              ((t (:background ,everforest-harder-gray :distant-foreground ,everforest-harder-mono-2))))
   `(highlight           ((t (:background ,everforest-harder-gray :distant-foreground ,everforest-harder-mono-2))))
   `(hl-line             ((t (:background ,everforest-harder-bg-hl :distant-foreground nil))))
   `(header-line         ((t (:background ,everforest-harder-black))))
   `(vertical-border     ((t (:background ,everforest-harder-border :foreground ,everforest-harder-border))))
   `(secondary-selection ((t (:background ,everforest-harder-bg-1))))
   `(query-replace       ((t (:inherit (isearch)))))
   `(minibuffer-prompt   ((t (:foreground ,everforest-harder-blue))))
   `(tooltip             ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg-1 :inherit variable-pitch))))

   `(font-lock-builtin-face           ((t (:foreground ,everforest-harder-cyan))))
   `(font-lock-comment-face           ((t (:foreground ,everforest-harder-mono-3 :slant italic))))
   `(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
   `(font-lock-doc-face               ((t (:inherit (font-lock-string-face)))))
   `(font-lock-function-name-face     ((t (:foreground ,everforest-harder-green))))
   `(font-lock-keyword-face           ((t (:foreground ,everforest-harder-red-1 :weight normal))))
   `(font-lock-preprocessor-face      ((t (:foreground ,everforest-harder-mono-2))))
   `(font-lock-string-face            ((t (:foreground ,everforest-harder-green))))
   `(font-lock-type-face              ((t (:foreground ,everforest-harder-purple))))
   `(font-lock-constant-face          ((t (:foreground ,everforest-harder-cyan))))
   `(font-lock-variable-name-face     ((t (:foreground ,everforest-harder-blue))))
   `(font-lock-warning-face           ((t (:foreground ,everforest-harder-mono-3 :bold t))))
   `(font-lock-negation-char-face     ((t (:foreground ,everforest-harder-cyan :bold t))))

   ;; eob
   `(vi-tilde-fringe-face ((t (:foreground ,everforest-harder-silver))))
   `(fringe               ((t (:foreground ,everforest-harder-silver))))

   ;; mode-line
   `(mode-line           ((t (:background ,everforest-harder-bg-hl :foreground ,everforest-harder-silver :box (:color ,everforest-harder-border :line-width 1)))))
   `(mode-line-buffer-id ((t (:weight bold))))
   `(mode-line-emphasis  ((t (:weight bold))))
   `(mode-line-inactive  ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-silver :box (:color ,everforest-harder-border :line-width 1)))))

   ;; window-divider
   `(window-divider             ((t (:foreground ,everforest-harder-border))))
   `(window-divider-first-pixel ((t (:foreground ,everforest-harder-border))))
   `(window-divider-last-pixel  ((t (:foreground ,everforest-harder-border))))

   ;; custom
   `(custom-state ((t (:foreground ,everforest-harder-green))))

   ;; Package/Plugin Customizations

   ;; ido
   `(ido-first-match ((t (:foreground ,everforest-harder-purple :weight bold))))
   `(ido-only-match  ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(ido-subdir      ((t (:foreground ,everforest-harder-blue))))
   `(ido-virtual     ((t (:foreground ,everforest-harder-mono-3))))

   ;; ace-jump
   `(ace-jump-face-background ((t (:foreground ,everforest-harder-mono-3 :background ,everforest-harder-bg-1 :inverse-video nil))))
   `(ace-jump-face-foreground ((t (:foreground ,everforest-harder-red-1 :background ,everforest-harder-bg-1 :inverse-video nil))))

   ;; ace-window
   `(aw-background-face   ((t (:inherit font-lock-comment-face))))
   `(aw-leading-char-face ((t (:foreground ,everforest-harder-red-1 :weight bold))))

   ;; centaur-tabs
   `(centaur-tabs-default           ((t (:background ,everforest-harder-black :foreground ,everforest-harder-black))))
   `(centaur-tabs-selected          ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-fg :weight bold))))
   `(centaur-tabs-unselected        ((t (:background ,everforest-harder-black :foreground ,everforest-harder-fg :weight light))))
   `(centaur-tabs-selected-modified ((t (:background ,everforest-harder-bg
                                                     :foreground ,everforest-harder-blue :weight bold))))
   `(centaur-tabs-unselected-modified ((t (:background ,everforest-harder-black :weight light
                                                       :foreground ,everforest-harder-blue))))
   `(centaur-tabs-active-bar-face            ((t (:background ,everforest-harder-accent))))
   `(centaur-tabs-modified-marker-selected   ((t (:inherit 'centaur-tabs-selected :foreground,everforest-harder-accent))))
   `(centaur-tabs-modified-marker-unselected ((t (:inherit 'centaur-tabs-unselected :foreground,everforest-harder-accent))))

   ;; company-mode
   `(company-tooltip                      ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg-1))))
   `(company-tooltip-annotation           ((t (:foreground ,everforest-harder-mono-2 :background ,everforest-harder-bg-1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,everforest-harder-mono-2 :background ,everforest-harder-gray))))
   `(company-tooltip-selection            ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-gray))))
   `(company-tooltip-mouse                ((t (:background ,everforest-harder-gray))))
   `(company-tooltip-common               ((t (:foreground ,everforest-harder-orange-2 :background ,everforest-harder-bg-1))))
   `(company-tooltip-common-selection     ((t (:foreground ,everforest-harder-orange-2 :background ,everforest-harder-gray))))
   `(company-preview                      ((t (:background ,everforest-harder-bg))))
   `(company-preview-common               ((t (:foreground ,everforest-harder-orange-2 :background ,everforest-harder-bg))))
   `(company-scrollbar-fg                 ((t (:background ,everforest-harder-mono-1))))
   `(company-scrollbar-bg                 ((t (:background ,everforest-harder-bg-1))))
   `(company-template-field               ((t (:inherit highlight))))

   ;; doom-modeline
   `(doom-modeline-bar ((t (:background ,everforest-harder-accent))))

   ;; flyspell
   `(flyspell-duplicate ((t (:underline (:color ,everforest-harder-cyan :style wave)))))
   `(flyspell-incorrect ((t (:underline (:color ,everforest-harder-red-1 :style wave)))))

   ;; flymake
   `(flymake-error   ((t (:underline (:color ,everforest-harder-red-1 :style wave)))))
   `(flymake-note    ((t (:underline (:color ,everforest-harder-green :style wave)))))
   `(flymake-warning ((t (:underline (:color ,everforest-harder-orange-1 :style wave)))))

   ;; flycheck
   `(flycheck-error   ((t (:underline (:color ,everforest-harder-red-1 :style wave)))))
   `(flycheck-info    ((t (:underline (:color ,everforest-harder-green :style wave)))))
   `(flycheck-warning ((t (:underline (:color ,everforest-harder-orange-1 :style wave)))))

   ;; compilation
   `(compilation-face           ((t (:foreground ,everforest-harder-fg))))
   `(compilation-line-number    ((t (:foreground ,everforest-harder-mono-2))))
   `(compilation-column-number  ((t (:foreground ,everforest-harder-mono-2))))
   `(compilation-mode-line-exit ((t (:inherit compilation-info :weight bold))))
   `(compilation-mode-line-fail ((t (:inherit compilation-error :weight bold))))

   ;; isearch
   `(isearch        ((t (:foreground ,everforest-harder-bg :background ,everforest-harder-purple))))
   `(isearch-fail   ((t (:foreground ,everforest-harder-red-2 :background nil))))
   `(lazy-highlight ((t (:foreground ,everforest-harder-purple :background ,everforest-harder-bg-1 :underline ,everforest-harder-purple))))

   ;; diff-hl (https://github.com/dgutov/diff-hl)
   '(diff-hl-change ((t (:foreground "#E9C062" :background "#8b733a"))))
   '(diff-hl-delete ((t (:foreground "#CC6666" :background "#7a3d3d"))))
   '(diff-hl-insert ((t (:foreground "#A8FF60" :background "#547f30"))))

   ;; dired-mode
   '(dired-directory ((t (:inherit (font-lock-keyword-face)))))
   '(dired-flagged       ((t (:inherit (diff-hl-delete)))))
   '(dired-symlink       ((t (:foreground "#FD5FF1"))))
   `(diredfl-file-name   ((t (:foreground ,everforest-harder-fg))))
   `(diredfl-file-suffix ((t (:foreground ,everforest-harder-fg))))
   `(diredfl-number      ((t (:foreground ,everforest-harder-red-1))))
   `(diredfl-date-time   ((t (:foreground ,everforest-harder-blue))))
   `(diredfl-no-priv     ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-dir-priv    ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-read-priv   ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-write-priv  ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-exec-priv   ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-link-priv   ((t (:foreground ,everforest-harder-orange-2))))
   `(diredfl-dir-heading ((t (:foreground ,everforest-harder-green :weight bold))))

   ;; dired-async
   `(dired-async-failures     ((t (:inherit error))))
   `(dired-async-message      ((t (:inherit success))))
   `(dired-async-mode-message ((t (:foreground ,everforest-harder-orange-1))))

   ;; helm
   `(helm-header ((t (:foreground ,everforest-harder-mono-2
                                  :background ,everforest-harder-bg
                                  :underline nil
                                  :box (:line-width 6 :color ,everforest-harder-bg)))))
   `(helm-source-header ((t (:foreground ,everforest-harder-orange-2
                                         :background ,everforest-harder-bg
                                         :underline nil
                                         :weight bold
                                         :box (:line-width 6 :color ,everforest-harder-bg)))))
   `(helm-selection                    ((t (:background ,everforest-harder-gray))))
   `(helm-selection-line               ((t (:background ,everforest-harder-gray))))
   `(helm-visible-mark                 ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-orange-2))))
   `(helm-candidate-number             ((t (:foreground ,everforest-harder-green :background ,everforest-harder-bg-1))))
   `(helm-separator                    ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-red-1))))
   `(helm-M-x-key                      ((t (:foreground ,everforest-harder-orange-1))))
   `(helm-bookmark-addressbook         ((t (:foreground ,everforest-harder-orange-1))))
   `(helm-bookmark-directory           ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file                ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus                ((t (:foreground ,everforest-harder-purple))))
   `(helm-bookmark-info                ((t (:foreground ,everforest-harder-green))))
   `(helm-bookmark-man                 ((t (:foreground ,everforest-harder-orange-2))))
   `(helm-bookmark-w3m                 ((t (:foreground ,everforest-harder-purple))))
   `(helm-match                        ((t (:foreground ,everforest-harder-orange-2))))
   `(helm-ff-directory                 ((t (:foreground ,everforest-harder-cyan :background ,everforest-harder-bg :weight bold))))
   `(helm-ff-file                      ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg :weight normal))))
   `(helm-ff-executable                ((t (:foreground ,everforest-harder-green :background ,everforest-harder-bg :weight normal))))
   `(helm-ff-invalid-symlink           ((t (:foreground ,everforest-harder-red-1 :background ,everforest-harder-bg :weight bold))))
   `(helm-ff-symlink                   ((t (:foreground ,everforest-harder-orange-2 :background ,everforest-harder-bg :weight bold))))
   `(helm-ff-prefix                    ((t (:foreground ,everforest-harder-bg :background ,everforest-harder-orange-2 :weight normal))))
   `(helm-buffer-not-saved             ((t (:foreground ,everforest-harder-red-1))))
   `(helm-buffer-process               ((t (:foreground ,everforest-harder-mono-2))))
   `(helm-buffer-saved-out             ((t (:foreground ,everforest-harder-fg))))
   `(helm-buffer-size                  ((t (:foreground ,everforest-harder-mono-2))))
   `(helm-buffer-directory             ((t (:foreground ,everforest-harder-purple))))
   `(helm-grep-cmd-line                ((t (:foreground ,everforest-harder-cyan))))
   `(helm-grep-file                    ((t (:foreground ,everforest-harder-fg))))
   `(helm-grep-finish                  ((t (:foreground ,everforest-harder-green))))
   `(helm-grep-lineno                  ((t (:foreground ,everforest-harder-mono-2))))
   `(helm-grep-finish                  ((t (:foreground ,everforest-harder-red-1))))
   `(helm-grep-match                   ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-swoop-target-line-block-face ((t (:background ,everforest-harder-mono-3 :foreground "#222222"))))
   `(helm-swoop-target-line-face       ((t (:background ,everforest-harder-mono-3 :foreground "#222222"))))
   `(helm-swoop-target-word-face       ((t (:background ,everforest-harder-purple :foreground "#ffffff"))))
   `(helm-locate-finish                ((t (:foreground ,everforest-harder-green))))
   `(info-menu-star                    ((t (:foreground ,everforest-harder-red-1))))

   ;; ivy
   `(ivy-confirm-face               ((t (:inherit minibuffer-prompt :foreground ,everforest-harder-green))))
   `(ivy-current-match              ((t (:background ,everforest-harder-gray :weight normal))))
   `(ivy-highlight-face             ((t (:inherit font-lock-builtin-face))))
   `(ivy-match-required-face        ((t (:inherit minibuffer-prompt :foreground ,everforest-harder-red-1))))
   `(ivy-minibuffer-match-face-1    ((t (:background ,everforest-harder-bg-hl))))
   `(ivy-minibuffer-match-face-2    ((t (:inherit ivy-minibuffer-match-face-1 :background ,everforest-harder-black :foreground ,everforest-harder-purple :weight semi-bold))))
   `(ivy-minibuffer-match-face-3    ((t (:inherit ivy-minibuffer-match-face-2 :background ,everforest-harder-black :foreground ,everforest-harder-green :weight semi-bold))))
   `(ivy-minibuffer-match-face-4    ((t (:inherit ivy-minibuffer-match-face-2 :background ,everforest-harder-black :foreground ,everforest-harder-orange-2 :weight semi-bold))))
   `(ivy-minibuffer-match-highlight ((t (:inherit ivy-current-match))))
   `(ivy-modified-buffer            ((t (:inherit default :foreground ,everforest-harder-orange-1))))
   `(ivy-virtual                    ((t (:inherit font-lock-builtin-face :slant italic))))

   ;; counsel
   `(counsel-key-binding ((t (:foreground ,everforest-harder-orange-2 :weight bold))))

   ;; swiper
   `(swiper-match-face-1 ((t (:inherit ivy-minibuffer-match-face-1))))
   `(swiper-match-face-2 ((t (:inherit ivy-minibuffer-match-face-2))))
   `(swiper-match-face-3 ((t (:inherit ivy-minibuffer-match-face-3))))
   `(swiper-match-face-4 ((t (:inherit ivy-minibuffer-match-face-4))))

   ;; git-commit
   `(git-commit-comment-action  ((t (:foreground ,everforest-harder-green :weight bold))))
   `(git-commit-comment-branch  ((t (:foreground ,everforest-harder-blue :weight bold))))
   `(git-commit-comment-heading ((t (:foreground ,everforest-harder-orange-2 :weight bold))))

   ;; git-gutter
   `(git-gutter:added    ((t (:foreground ,everforest-harder-green :weight bold))))
   `(git-gutter:deleted  ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(git-gutter:modified ((t (:foreground ,everforest-harder-orange-1 :weight bold))))

   ;; eshell
   `(eshell-ls-archive    ((t (:foreground ,everforest-harder-purple :weight bold))))
   `(eshell-ls-backup     ((t (:foreground ,everforest-harder-orange-2))))
   `(eshell-ls-clutter    ((t (:foreground ,everforest-harder-red-2 :weight bold))))
   `(eshell-ls-directory  ((t (:foreground ,everforest-harder-blue :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,everforest-harder-green :weight bold))))
   `(eshell-ls-missing    ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(eshell-ls-product    ((t (:foreground ,everforest-harder-orange-2))))
   `(eshell-ls-special    ((t (:foreground "#FD5FF1" :weight bold))))
   `(eshell-ls-symlink    ((t (:foreground ,everforest-harder-cyan :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,everforest-harder-mono-1))))
   `(eshell-prompt        ((t (:inherit minibuffer-prompt))))

   ;; man
   `(Man-overstrike ((t (:foreground ,everforest-harder-green :weight bold))))
   `(Man-underline  ((t (:inherit font-lock-keyword-face :slant italic :weight bold))))

   ;; woman
   `(woman-bold   ((t (:foreground ,everforest-harder-green :weight bold))))
   `(woman-italic ((t (:inherit font-lock-keyword-face :slant italic :weight bold))))

   ;; dictionary
   `(dictionary-button-face     ((t (:inherit widget-button))))
   `(dictionary-reference-face  ((t (:inherit font-lock-type-face :weight bold))))
   `(dictionary-word-entry-face ((t (:inherit font-lock-keyword-face :slant italic :weight bold))))

   ;; erc
   `(erc-error-face     ((t (:inherit error))))
   `(erc-input-face     ((t (:inherit shadow))))
   `(erc-my-nick-face   ((t (:foreground ,everforest-harder-accent))))
   `(erc-notice-face    ((t (:inherit font-lock-comment-face))))
   `(erc-timestamp-face ((t (:foreground ,everforest-harder-green :weight bold))))

   ;; jabber
   `(jabber-roster-user-online     ((t (:foreground ,everforest-harder-green))))
   `(jabber-roster-user-away       ((t (:foreground ,everforest-harder-red-1))))
   `(jabber-roster-user-xa         ((t (:foreground ,everforest-harder-red-2))))
   `(jabber-roster-user-dnd        ((t (:foreground ,everforest-harder-purple))))
   `(jabber-roster-user-chatty     ((t (:foreground ,everforest-harder-orange-2))))
   `(jabber-roster-user-error      ((t (:foreground ,everforest-harder-red-1 :bold t))))
   `(jabber-roster-user-offline    ((t (:foreground ,everforest-harder-mono-3))))
   `(jabber-chat-prompt-local      ((t (:foreground ,everforest-harder-blue))))
   `(jabber-chat-prompt-foreign    ((t (:foreground ,everforest-harder-orange-2))))
   `(jabber-chat-prompt-system     ((t (:foreground ,everforest-harder-mono-3))))
   `(jabber-chat-error             ((t (:inherit jabber-roster-user-error))))
   `(jabber-rare-time-face         ((t (:foreground ,everforest-harder-cyan))))
   `(jabber-activity-face          ((t (:inherit jabber-chat-prompt-foreign))))
   `(jabber-activity-personal-face ((t (:inherit jabber-chat-prompt-local))))

   ;; eww
   `(eww-form-checkbox       ((t (:inherit eww-form-submit))))
   `(eww-form-file           ((t (:inherit eww-form-submit))))
   `(eww-form-select         ((t (:inherit eww-form-submit))))
   `(eww-form-submit         ((t (:background ,everforest-harder-gray :foreground ,everforest-harder-fg :box (:line-width 2 :color ,everforest-harder-border :style released-button)))))
   `(eww-form-text           ((t (:inherit widget-field :box (:line-width 1 :color ,everforest-harder-border)))))
   `(eww-form-textarea       ((t (:inherit eww-form-text))))
   `(eww-invalid-certificate ((t (:foreground ,everforest-harder-red-1))))
   `(eww-valid-certificate   ((t (:foreground ,everforest-harder-green))))

   ;; ediff
   `(ediff-fine-diff-Ancestor      ((t (:background "#885555"))))
   `(ediff-fine-diff-A             ((t (:background "#885555"))))
   `(ediff-fine-diff-B             ((t (:background "#558855"))))
   `(ediff-fine-diff-C             ((t (:background "#555588"))))
   `(ediff-current-diff-Ancestor   ((t (:background "#663333"))))
   `(ediff-current-diff-A          ((t (:background "#663333"))))
   `(ediff-current-diff-B          ((t (:background "#336633"))))
   `(ediff-current-diff-C          ((t (:background "#333366"))))
   `(ediff-even-diff-Ancestor      ((t (:background "#181a1f"))))
   `(ediff-even-diff-A             ((t (:background "#181a1f"))))
   `(ediff-even-diff-B             ((t (:background "#181a1f"))))
   `(ediff-even-diff-C             ((t (:background "#181a1f"))))
   `(ediff-odd-diff-Ancestor       ((t (:background "#181a1f"))))
   `(ediff-odd-diff-A              ((t (:background "#181a1f"))))
   `(ediff-odd-diff-B              ((t (:background "#181a1f"))))
   `(ediff-odd-diff-C              ((t (:background "#181a1f"))))

   ;; magit
   `(magit-section-highlight           ((t (:background ,everforest-harder-bg-hl))))
   `(magit-section-heading             ((t (:foreground ,everforest-harder-orange-2 :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,everforest-harder-fg :weight bold))))
   `(magit-diff-file-heading           ((t (:weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,everforest-harder-gray :weight bold))))
   `(magit-diff-file-heading-selection ((t (:foreground ,everforest-harder-orange-2 :background ,everforest-harder-bg-hl :weight bold))))
   `(magit-diff-hunk-heading           ((t (:foreground ,everforest-harder-mono-2 :background ,everforest-harder-gray))))
   `(magit-diff-hunk-heading-highlight ((t (:foreground ,everforest-harder-mono-1 :background ,everforest-harder-mono-3))))
   `(magit-diff-hunk-heading-selection ((t (:foreground ,everforest-harder-purple :background ,everforest-harder-mono-3))))
   `(magit-diff-context                ((t (:foreground ,everforest-harder-fg))))
   `(magit-diff-context-highlight      ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-fg))))
   `(magit-diffstat-added              ((t (:foreground ,everforest-harder-green))))
   `(magit-diffstat-removed            ((t (:foreground ,everforest-harder-red-1))))
   `(magit-process-ok                  ((t (:foreground ,everforest-harder-green))))
   `(magit-process-ng                  ((t (:foreground ,everforest-harder-red-1))))
   `(magit-log-author                  ((t (:foreground ,everforest-harder-orange-2))))
   `(magit-log-date                    ((t (:foreground ,everforest-harder-mono-2))))
   `(magit-log-graph                   ((t (:foreground ,everforest-harder-silver))))
   `(magit-sequence-pick               ((t (:foreground ,everforest-harder-orange-2))))
   `(magit-sequence-stop               ((t (:foreground ,everforest-harder-green))))
   `(magit-sequence-part               ((t (:foreground ,everforest-harder-orange-1))))
   `(magit-sequence-head               ((t (:foreground ,everforest-harder-blue))))
   `(magit-sequence-drop               ((t (:foreground ,everforest-harder-red-1))))
   `(magit-sequence-done               ((t (:foreground ,everforest-harder-mono-2))))
   `(magit-sequence-onto               ((t (:foreground ,everforest-harder-mono-2))))
   `(magit-bisect-good                 ((t (:foreground ,everforest-harder-green))))
   `(magit-bisect-skip                 ((t (:foreground ,everforest-harder-orange-1))))
   `(magit-bisect-bad                  ((t (:foreground ,everforest-harder-red-1))))
   `(magit-blame-heading               ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-mono-2))))
   `(magit-blame-hash                  ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-purple))))
   `(magit-blame-name                  ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-orange-2))))
   `(magit-blame-date                  ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-mono-3))))
   `(magit-blame-summary               ((t (:background ,everforest-harder-bg-1 :foreground ,everforest-harder-mono-2))))
   `(magit-dimmed                      ((t (:foreground ,everforest-harder-mono-2))))
   `(magit-hash                        ((t (:foreground ,everforest-harder-purple))))
   `(magit-tag                         ((t (:foreground ,everforest-harder-orange-1 :weight bold))))
   `(magit-branch-remote               ((t (:foreground ,everforest-harder-green :weight bold))))
   `(magit-branch-local                ((t (:foreground ,everforest-harder-blue :weight bold))))
   `(magit-branch-current              ((t (:foreground ,everforest-harder-blue :weight bold :box t))))
   `(magit-head                        ((t (:foreground ,everforest-harder-blue :weight bold))))
   `(magit-refname                     ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-fg :weight bold))))
   `(magit-refname-stash               ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-fg :weight bold))))
   `(magit-refname-wip                 ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-fg :weight bold))))
   `(magit-signature-good              ((t (:foreground ,everforest-harder-green))))
   `(magit-signature-bad               ((t (:foreground ,everforest-harder-red-1))))
   `(magit-signature-untrusted         ((t (:foreground ,everforest-harder-orange-1))))
   `(magit-cherry-unmatched            ((t (:foreground ,everforest-harder-cyan))))
   `(magit-cherry-equivalent           ((t (:foreground ,everforest-harder-purple))))
   `(magit-reflog-commit               ((t (:foreground ,everforest-harder-green))))
   `(magit-reflog-amend                ((t (:foreground ,everforest-harder-purple))))
   `(magit-reflog-merge                ((t (:foreground ,everforest-harder-green))))
   `(magit-reflog-checkout             ((t (:foreground ,everforest-harder-blue))))
   `(magit-reflog-reset                ((t (:foreground ,everforest-harder-red-1))))
   `(magit-reflog-rebase               ((t (:foreground ,everforest-harder-purple))))
   `(magit-reflog-cherry-pick          ((t (:foreground ,everforest-harder-green))))
   `(magit-reflog-remote               ((t (:foreground ,everforest-harder-cyan))))
   `(magit-reflog-other                ((t (:foreground ,everforest-harder-cyan))))

   ;; message
   `(message-cited-text         ((t (:foreground ,everforest-harder-green))))
   `(message-header-cc          ((t (:foreground ,everforest-harder-orange-1 :weight bold))))
   `(message-header-name        ((t (:foreground ,everforest-harder-purple))))
   `(message-header-newsgroups  ((t (:foreground ,everforest-harder-orange-2 :weight bold :slant italic))))
   `(message-header-other       ((t (:foreground ,everforest-harder-red-1))))
   `(message-header-subject     ((t (:foreground ,everforest-harder-blue))))
   `(message-header-to          ((t (:foreground ,everforest-harder-orange-2 :weight bold))))
   `(message-header-xheader     ((t (:foreground ,everforest-harder-silver))))
   `(message-mml                ((t (:foreground ,everforest-harder-purple))))
   `(message-separator          ((t (:foreground ,everforest-harder-mono-3 :slant italic))))

   ;; epa
   `(epa-field-body ((t (:foreground ,everforest-harder-blue :slant italic))))
   `(epa-field-name ((t (:foreground ,everforest-harder-cyan :weight bold))))

   ;; notmuch
   `(notmuch-crypto-decryption            ((t (:foreground ,everforest-harder-purple :background ,everforest-harder-black))))
   `(notmuch-crypto-signature-bad         ((t (:foreground ,everforest-harder-red-1 :background ,everforest-harder-black))))
   `(notmuch-crypto-signature-good        ((t (:foreground ,everforest-harder-green :background ,everforest-harder-black))))
   `(notmuch-crypto-signature-good-key    ((t (:foreground ,everforest-harder-green :background ,everforest-harder-black))))
   `(notmuch-crypto-signature-unknown     ((t (:foreground ,everforest-harder-orange-1 :background ,everforest-harder-black))))
   `(notmuch-hello-logo-background        ((t (:inherit default))))
   `(notmuch-message-summary-face         ((t (:background ,everforest-harder-black))))
   `(notmuch-search-count                 ((t (:inherit default :foreground ,everforest-harder-silver))))
   `(notmuch-search-date                  ((t (:inherit default :foreground ,everforest-harder-purple))))
   `(notmuch-search-matching-authors      ((t (:inherit default :foreground ,everforest-harder-orange-2))))
   `(notmuch-search-non-matching-authors  ((t (:inherit font-lock-comment-face :slant italic))))
   `(notmuch-tag-added                    ((t (:underline t))))
   `(notmuch-tag-deleted                  ((t (:strike-through ,everforest-harder-red-2))))
   `(notmuch-tag-face                     ((t (:foreground ,everforest-harder-green))))
   `(notmuch-tag-unread                   ((t (:foreground ,everforest-harder-red-1))))
   `(notmuch-tree-match-author-face       ((t (:inherit notmuch-search-matching-authors))))
   `(notmuch-tree-match-date-face         ((t (:inherit notmuch-search-date))))
   `(notmuch-tree-match-face              ((t (:weight semi-bold))))
   `(notmuch-tree-match-tag-face          ((t (:inherit notmuch-tag-face))))
   `(notmuch-tree-no-match-face           ((t (:slant italic :weight light :inherit font-lock-comment-face))))

   ;; mu4e
   `(mu4e-header-key-face      ((t (:foreground ,everforest-harder-green :weight bold))))
   `(mu4e-header-title-face    ((t (:foreground ,everforest-harder-blue))))
   `(mu4e-title-face           ((t (:foreground ,everforest-harder-green :weight bold))))

   ;; elfeed
   `(elfeed-log-debug-level-face      ((t (:background ,everforest-harder-black :foreground ,everforest-harder-green))))
   `(elfeed-log-error-level-face      ((t (:background ,everforest-harder-black :foreground ,everforest-harder-red-1))))
   `(elfeed-log-info-level-face       ((t (:background ,everforest-harder-black :foreground ,everforest-harder-blue))))
   `(elfeed-log-warn-level-face       ((t (:background ,everforest-harder-black :foreground ,everforest-harder-orange-1))))
   `(elfeed-search-date-face          ((t (:foreground ,everforest-harder-purple))))
   `(elfeed-search-feed-face          ((t (:foreground ,everforest-harder-orange-2))))
   `(elfeed-search-tag-face           ((t (:foreground ,everforest-harder-green))))
   `(elfeed-search-title-face         ((t (:foreground ,everforest-harder-mono-1))))
   `(elfeed-search-unread-count-face  ((t (:foreground ,everforest-harder-silver))))

   ;; perspective
   `(persp-selected-face ((t (:foreground ,everforest-harder-blue))))

   ;; powerline
   `(powerline-active1    ((,class (:background ,everforest-harder-bg-hl :foreground ,everforest-harder-purple))))
   `(powerline-active2    ((,class (:background ,everforest-harder-bg-hl :foreground ,everforest-harder-purple))))
   `(powerline-inactive1  ((,class (:background ,everforest-harder-bg :foreground ,everforest-harder-fg))))
   `(powerline-inactive2  ((,class (:background ,everforest-harder-bg :foreground ,everforest-harder-fg))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face    ((t (:foreground ,everforest-harder-green))))
   `(rainbow-delimiters-depth-2-face    ((t (:foreground ,everforest-harder-red-1))))
   `(rainbow-delimiters-depth-3-face    ((t (:foreground ,everforest-harder-blue))))
   `(rainbow-delimiters-depth-4-face    ((t (:foreground ,everforest-harder-cyan))))
   `(rainbow-delimiters-depth-5-face    ((t (:foreground ,everforest-harder-purple))))
   `(rainbow-delimiters-depth-6-face    ((t (:foreground ,everforest-harder-orange-2))))
   `(rainbow-delimiters-depth-7-face    ((t (:foreground ,everforest-harder-orange-1))))
   `(rainbow-delimiters-depth-8-face    ((t (:foreground ,everforest-harder-green))))
   `(rainbow-delimiters-depth-9-face    ((t (:foreground ,everforest-harder-orange-1))))
   `(rainbow-delimiters-depth-10-face   ((t (:foreground ,everforest-harder-cyan))))
   `(rainbow-delimiters-depth-11-face   ((t (:foreground ,everforest-harder-purple))))
   `(rainbow-delimiters-depth-12-face   ((t (:foreground ,everforest-harder-orange-2))))
   `(rainbow-delimiters-unmatched-face  ((t (:foreground ,everforest-harder-red-1 :weight bold))))

   ;; rbenv
   `(rbenv-active-ruby-face ((t (:foreground ,everforest-harder-green))))

   ;; elixir
   `(elixir-atom-face       ((t (:foreground ,everforest-harder-cyan))))
   `(elixir-attribute-face  ((t (:foreground ,everforest-harder-red-1))))

   ;; show-paren
   `(show-paren-match     ((,class (:foreground ,everforest-harder-purple :inherit bold :underline t))))
   `(show-paren-mismatch  ((,class (:foreground ,everforest-harder-red-1 :inherit bold :underline t))))

   ;; cider
   `(cider-fringe-good-face ((t (:foreground ,everforest-harder-green))))

   ;; sly
   `(sly-error-face          ((t (:underline (:color ,everforest-harder-red-1 :style wave)))))
   `(sly-mrepl-note-face     ((t (:inherit font-lock-comment-face))))
   `(sly-mrepl-output-face   ((t (:inherit font-lock-string-face))))
   `(sly-mrepl-prompt-face   ((t (:inherit comint-highlight-prompt))))
   `(sly-note-face           ((t (:underline (:color ,everforest-harder-green :style wave)))))
   `(sly-style-warning-face  ((t (:underline (:color ,everforest-harder-orange-2 :style wave)))))
   `(sly-warning-face        ((t (:underline (:color ,everforest-harder-orange-1 :style wave)))))

   ;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,everforest-harder-red-1 :background ,everforest-harder-gray :weight bold))))
   `(sp-show-pair-match-face    ((t (:foreground ,everforest-harder-blue :weight bold :underline t))))

   ;; lispy
   `(lispy-face-hint ((t (:background ,everforest-harder-border :foreground ,everforest-harder-orange-2))))

   ;; lispyville
   `(lispyville-special-face ((t (:foreground ,everforest-harder-red-1))))

   ;; spaceline
   `(spaceline-flycheck-error    ((,class (:foreground ,everforest-harder-red-1))))
   `(spaceline-flycheck-info     ((,class (:foreground ,everforest-harder-green))))
   `(spaceline-flycheck-warning  ((,class (:foreground ,everforest-harder-orange-1))))
   `(spaceline-python-venv       ((,class (:foreground ,everforest-harder-purple))))

   ;; solaire mode
   `(solaire-default-face      ((,class (:inherit default :background ,everforest-harder-black))))
   `(solaire-minibuffer-face   ((,class (:inherit default :background ,everforest-harder-black))))

   ;; web-mode
   `(web-mode-doctype-face            ((t (:inherit font-lock-comment-face))))
   `(web-mode-error-face              ((t (:background ,everforest-harder-black :foreground ,everforest-harder-red-1))))
   `(web-mode-html-attr-equal-face    ((t (:inherit default))))
   `(web-mode-html-attr-name-face     ((t (:foreground ,everforest-harder-orange-1))))
   `(web-mode-html-tag-bracket-face   ((t (:inherit default))))
   `(web-mode-html-tag-face           ((t (:foreground ,everforest-harder-red-1))))
   `(web-mode-symbol-face             ((t (:foreground ,everforest-harder-orange-1))))

   ;; nxml
   `(nxml-attribute-local-name             ((t (:foreground ,everforest-harder-orange-1))))
   `(nxml-element-local-name               ((t (:foreground ,everforest-harder-red-1))))
   `(nxml-markup-declaration-delimiter     ((t (:inherit (font-lock-comment-face nxml-delimiter)))))
   `(nxml-processing-instruction-delimiter ((t (:inherit nxml-markup-declaration-delimiter))))

   ;; flx-ido
   `(flx-highlight-face ((t (:inherit (link) :weight bold))))

   ;; rpm-spec-mode
   `(rpm-spec-tag-face          ((t (:foreground ,everforest-harder-blue))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground "#FFFFFF" :background ,everforest-harder-red-2))))
   `(rpm-spec-macro-face        ((t (:foreground ,everforest-harder-orange-2))))
   `(rpm-spec-var-face          ((t (:foreground ,everforest-harder-red-1))))
   `(rpm-spec-doc-face          ((t (:foreground ,everforest-harder-purple))))
   `(rpm-spec-dir-face          ((t (:foreground ,everforest-harder-cyan))))
   `(rpm-spec-package-face      ((t (:foreground ,everforest-harder-red-2))))
   `(rpm-spec-ghost-face        ((t (:foreground ,everforest-harder-red-2))))
   `(rpm-spec-section-face      ((t (:foreground ,everforest-harder-orange-2))))

   ;; guix
   `(guix-true ((t (:foreground ,everforest-harder-green :weight bold))))
   `(guix-build-log-phase-end ((t (:inherit success))))
   `(guix-build-log-phase-start ((t (:inherit success :weight bold))))

   ;; gomoku
   `(gomoku-O ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(gomoku-X ((t (:foreground ,everforest-harder-green :weight bold))))

   ;; tabbar
   `(tabbar-default             ((,class (:foreground ,everforest-harder-fg :background ,everforest-harder-black))))
   `(tabbar-highlight           ((,class (:underline t))))
   `(tabbar-button              ((,class (:foreground ,everforest-harder-fg :background ,everforest-harder-bg))))
   `(tabbar-button-highlight    ((,class (:inherit 'tabbar-button :inverse-video t))))
   `(tabbar-modified            ((,class (:inherit tabbar-button :foreground ,everforest-harder-purple :weight light :slant italic))))
   `(tabbar-unselected          ((,class (:inherit tabbar-default :foreground ,everforest-harder-fg :background ,everforest-harder-black :slant italic :underline nil :box (:line-width 1 :color ,everforest-harder-bg)))))
   `(tabbar-unselected-modified ((,class (:inherit tabbar-modified :background ,everforest-harder-black :underline nil :box (:line-width 1 :color ,everforest-harder-bg)))))
   `(tabbar-selected            ((,class (:inherit tabbar-default :foreground ,everforest-harder-fg :background ,everforest-harder-bg :weight bold :underline nil :box (:line-width 1 :color ,everforest-harder-bg)))))
   `(tabbar-selected-modified   ((,class (:inherit tabbar-selected :foreground ,everforest-harder-purple :underline nil :box (:line-width 1 :color ,everforest-harder-bg)))))

   ;; linum
   `(linum                    ((t (:foreground ,everforest-harder-gutter :background ,everforest-harder-bg))))
   ;; hlinum
   `(linum-highlight-face     ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg))))
   ;; native line numbers (emacs version >=26)
   `(line-number              ((t (:foreground ,everforest-harder-gutter :background ,everforest-harder-bg))))
   `(line-number-current-line ((t (:foreground ,everforest-harder-fg :background ,everforest-harder-bg))))

   ;; regexp-builder
   `(reb-match-0 ((t (:background ,everforest-harder-gray))))
   `(reb-match-1 ((t (:background ,everforest-harder-black :foreground ,everforest-harder-purple :weight semi-bold))))
   `(reb-match-2 ((t (:background ,everforest-harder-black :foreground ,everforest-harder-green :weight semi-bold))))
   `(reb-match-3 ((t (:background ,everforest-harder-black :foreground ,everforest-harder-orange-2 :weight semi-bold))))

   ;; desktop-entry
   `(desktop-entry-deprecated-keyword-face ((t (:inherit font-lock-warning-face))))
   `(desktop-entry-group-header-face       ((t (:inherit font-lock-type-face))))
   `(desktop-entry-locale-face             ((t (:inherit font-lock-string-face))))
   `(desktop-entry-unknown-keyword-face    ((t (:underline (:color ,everforest-harder-red-1 :style wave) :inherit font-lock-keyword-face))))
   `(desktop-entry-value-face              ((t (:inherit default))))

   ;; calendar
   `(diary   ((t (:inherit warning))))
   `(holiday ((t (:foreground ,everforest-harder-green))))

   ;; gud
   `(breakpoint-disabled ((t (:foreground ,everforest-harder-orange-1))))
   `(breakpoint-enabled  ((t (:foreground ,everforest-harder-red-1 :weight bold))))

   ;; realgud
   `(realgud-overlay-arrow1        ((t (:foreground ,everforest-harder-green))))
   `(realgud-overlay-arrow3        ((t (:foreground ,everforest-harder-orange-1))   `(realgud-overlay-arrow2        ((t (:foreground ,everforest-harder-orange-2))))
                                    ))
   '(realgud-bp-enabled-face       ((t (:inherit (error)))))
   `(realgud-bp-disabled-face      ((t (:inherit (secondary-selection)))))
   `(realgud-bp-line-enabled-face  ((t (:box (:color ,everforest-harder-red-1)))))
   `(realgud-bp-line-disabled-face ((t (:box (:color ,everforest-harder-gray)))))
   `(realgud-line-number           ((t (:foreground ,everforest-harder-mono-2))))
   `(realgud-backtrace-number      ((t (:inherit (secondary-selection)))))

   ;; rmsbolt
   `(rmsbolt-current-line-face ((t (:inherit hl-line :weight bold))))

   ;; ruler-mode
   `(ruler-mode-column-number  ((t (:inherit ruler-mode-default))))
   `(ruler-mode-comment-column ((t (:foreground ,everforest-harder-red-1))))
   `(ruler-mode-current-column ((t (:foreground ,everforest-harder-accent :inherit ruler-mode-default))))
   `(ruler-mode-default        ((t (:inherit mode-line))))
   `(ruler-mode-fill-column    ((t (:foreground ,everforest-harder-orange-1 :inherit ruler-mode-default))))
   `(ruler-mode-fringes        ((t (:foreground ,everforest-harder-green :inherit ruler-mode-default))))
   `(ruler-mode-goal-column    ((t (:foreground ,everforest-harder-cyan :inherit ruler-mode-default))))
   `(ruler-mode-margins        ((t (:inherit ruler-mode-default))))
   `(ruler-mode-tab-stop       ((t (:foreground ,everforest-harder-mono-3 :inherit ruler-mode-default))))

   ;; undo-tree
   `(undo-tree-visualizer-current-face    ((t (:foreground ,everforest-harder-red-2))))
   `(undo-tree-visualizer-register-face   ((t (:foreground ,everforest-harder-orange-1))))
   `(undo-tree-visualizer-unmodified-face ((t (:foreground ,everforest-harder-cyan))))

   ;; tab-bar-mode
   `(tab-bar-tab-inactive ((t (:background ,everforest-harder-bg-hl :foreground ,everforest-harder-fg))))
   `(tab-bar-tab          ((t (:background ,everforest-harder-bg :foreground ,everforest-harder-purple))))
   `(tab-bar              ((t (:background ,everforest-harder-bg-hl))))

   ;; all-the-icons
   `(all-the-icons-purple    ((t (:foreground ,everforest-harder-purple))))
   `(all-the-icons-yellow    ((t (:foreground ,everforest-harder-orange-2))))

   ;; dashboard
   `(dashboard-heading        ((t (:foreground ,everforest-harder-green))))
   `(dashboard-items-face     ((t (:bold ,everforest-harder-green))))

   ;; Language Customizations ----------------------------------------------------------------------
   ;; these laguage customizations are seperate from certain larger lagu

   ;; markdown
   `(markdown-header-face-1            ((t (:foreground ,everforest-harder-red-1 :weight bold))))
   `(markdown-header-face-2            ((t (:foreground ,everforest-harder-orange-1 :weight bold))))
   `(markdown-link-face                ((t (:foreground ,everforest-harder-purple ))))
   `(markdown-url-face                 ((t (:foreground ,everforest-harder-blue :underline t))))
   `(markdown-plain-url-face           ((t (:foreground ,everforest-harder-blue))))
   `(markdown-header-delimiter-face    ((t (:foreground ,everforest-harder-silver))))
   `(markdown-language-keyword-face    ((t (:foreground ,everforest-harder-green))))
   `(markdown-markup-face              ((t (:foreground ,everforest-harder-silver))))
   `(markdown-pre-face                 ((t (:foreground ,everforest-harder-green))))
   `(markdown-metadata-key-face        ((t (:foreground ,everforest-harder-green))))

   ;; org-mode
   `(org-date                  ((t (:foreground ,everforest-harder-cyan))))
   `(org-document-info         ((t (:foreground ,everforest-harder-mono-3))))
   `(org-document-info-keyword ((t (:inherit org-meta-line :underline t))))
   `(org-document-title        ((t (:weight bold))))
   `(org-footnote              ((t (:foreground ,everforest-harder-cyan))))
   `(org-sexp-date             ((t (:foreground ,everforest-harder-cyan))))
   `(org-table                 ((t (:foreground ,everforest-harder-blue))))
   `(org-drawer                ((t (:foreground ,everforest-harder-blue))))
   `(org-headline-done         ((t (:foreground ,everforest-harder-purple))))
   `(org-level-1               ((t (:foreground ,everforest-harder-green))))
   `(org-level-2               ((t (:foreground ,everforest-harder-red-1))))
   `(org-level-3               ((t (:foreground ,everforest-harder-purple))))
   `(org-level-4               ((t (:foreground ,everforest-harder-orange-1))))
   `(org-level-6               ((t (:foreground ,everforest-harder-blue))))
   `(org-level-7               ((t (:foreground ,everforest-harder-silver))))
   `(org-level-8               ((t (:foreground ,everforest-harder-cyan))))

   ;; latex-mode
   `(font-latex-sectioning-0-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-sectioning-1-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-sectioning-2-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-sectioning-3-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-sectioning-4-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-sectioning-5-face        ((t (:foreground ,everforest-harder-blue :height 1.0))))
   `(font-latex-bold-face                ((t (:foreground ,everforest-harder-green :weight bold))))
   `(font-latex-italic-face              ((t (:foreground ,everforest-harder-green :slant 'italic))))
   `(font-latex-warning-face             ((t (:foreground ,everforest-harder-red-1))))
   `(font-latex-doctex-preprocessor-face ((t (:foreground ,everforest-harder-cyan))))
   `(font-latex-script-char-face         ((t (:foreground ,everforest-harder-mono-2))))

   ;; sh-mode
   `(sh-heredoc ((t (:inherit font-lock-string-face :slant italic))))

   ;; js2-mode
   `(js2-error             ((t (:underline (:color ,everforest-harder-red-1 :style wave)))))
   `(js2-external-variable ((t (:foreground ,everforest-harder-cyan))))
   `(js2-warning           ((t (:underline (:color ,everforest-harder-orange-1 :style wave)))))
   `(js2-function-call     ((t (:inherit (font-lock-function-name-face)))))
   `(js2-function-param    ((t (:foreground ,everforest-harder-mono-1))))
   `(js2-jsdoc-tag         ((t (:foreground ,everforest-harder-purple))))
   `(js2-jsdoc-type        ((t (:foreground ,everforest-harder-orange-2))))
   `(js2-jsdoc-value       ((t (:foreground ,everforest-harder-red-1))))
   `(js2-object-property   ((t (:foreground ,everforest-harder-red-1))))

   ))

(everforest-harder-with-color-variables
  (custom-theme-set-variables
   'everforest-harder
   ;; fill-column-indicator
   `(fci-rule-color ,everforest-harder-gray)

   ;; tetris
   ;; | Tetromino | Color                    |
   ;; | O         | `everforest-harder-orange-2' |
   ;; | J         | `everforest-harder-blue'     |
   ;; | L         | `everforest-harder-orange-1' |
   ;; | Z         | `everforest-harder-red-1'    |
   ;; | S         | `everforest-harder-green'    |
   ;; | T         | `everforest-harder-purple'   |
   ;; | I         | `everforest-harder-cyan'     |
   '(tetris-x-colors
     [[229 192 123] [97 175 239] [209 154 102] [224 108 117] [152 195 121] [198 120 221] [86 182 194]])

   ;; ansi-color
   `(ansi-color-names-vector
     [,everforest-harder-black ,everforest-harder-red-1 ,everforest-harder-green ,everforest-harder-orange-2
      ,everforest-harder-blue ,everforest-harder-purple ,everforest-harder-cyan ,everforest-harder-fg])
   ))

(defvar everforest-harder-theme-force-faces-for-mode t
  "If t, everforest-harder-theme will use Face Remapping to alter the theme faces for
the current buffer based on its mode in an attempt to mimick the Atom One Dark
Theme from Atom.io as best as possible.
The reason this is required is because some modes (html-mode, jyaml-mode, ...)
do not provide the necessary faces to do theming without conflicting with other
modes.
Current modes, and their faces, impacted by this variable:
* js2-mode: font-lock-constant-face, font-lock-doc-face, font-lock-variable-name-face
* html-mode: font-lock-function-name-face, font-lock-variable-name-face
")

;; Many modes in Emacs do not define their own faces and instead use standard Emacs faces when it comes to theming.
;; That being said, to have a real "Atom One Dark Theme" for Emacs, we need to work around this so that these themes look
;; as much like "Atom One Dark Theme" as possible.  This means using per-buffer faces via "Face Remapping":
;;
;;   http://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Remapping.html
;;
;; Of course, this might be confusing to some when in one mode they see keywords highlighted in one face and in another
;; mode they see a different face.  That being said, you can set the `everforest-harder-theme-force-faces-for-mode` variable to
;; `nil` to disable this feature.
(defun everforest-harder-theme-change-faces-for-mode ()
  (interactive)
  (when (or everforest-harder-theme-force-faces-for-mode (called-interactively-p))
    (everforest-harder-with-color-variables
      (cond
       ((member major-mode '(js2-mode))
        (face-remap-add-relative 'font-lock-constant-face :foreground everforest-harder-orange-1)
        (face-remap-add-relative 'font-lock-doc-face '(:inherit (font-lock-comment-face)))
        (face-remap-add-relative 'font-lock-variable-name-face :foreground everforest-harder-mono-1))
       ((member major-mode '(html-mode))
        (face-remap-add-relative 'font-lock-function-name-face :foreground everforest-harder-red-1)
        (face-remap-add-relative 'font-lock-variable-name-face :foreground everforest-harder-orange-1))))))

(add-hook 'after-change-major-mode-hook 'everforest-harder-theme-change-faces-for-mode)

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'everforest-harder)

;; Local Variables:
;; no-byte-compile: t
;; End:
;;; everforest-harder-theme.el ends here
