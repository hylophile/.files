;;; doom-srcery-theme.el -*- lexical-binding: t;no-byte-compile: t -*-

;;; Commentary:
(require 'doom-themes)
;;; Code:
;;
(defgroup doom-srcery-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-srcery-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-srcery-theme
  :type 'boolean)

(defcustom doom-srcery-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-srcery-theme
  :type 'boolean)

(defcustom doom-srcery-org-height t
  "If non-nil, org headers will render with different heights."
  :group 'doom-srcery-theme
  :type 'boolean)

(defcustom doom-srcery-comment-bg doom-srcery-brighter-comments
  "If non-nil, comments will have a subtle, darker background.
Enhancing their legibility."
  :group 'doom-srcery-theme
  :type 'boolean)

(defcustom doom-srcery-invert-region t
  "If non-nil, region will be highlighted with reverse video."
  :group 'doom-srcery-theme
  :type 'boolean)

(defcustom doom-srcery-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-srcery-theme
  :type '(choice integer boolean))

(def-doom-theme doom-srcery
  "A port of Srcery-colors to Emacs"

  ((bg         '("#1C1B19" "color-233"))
   (bg-alt     '("#121212" "color-16"))
   (base0      '("#121212" "color-235"))
   (base1      '("#262626" "color-235")) ; gray1
   (base2      '("#3A3A3A" "color-235")) ; gray3
   (base3      '("#4E4E4E" "color-237")) ; gray5
   (base4      '("#585858" "color-239")) ; gray6
   (base5      '("#6e6e6e" "color-242")) ;
   (base6      '("#918175" "color-244")) ; bright-black
   (base7      '("#BAA67F" "color-247")) ; white
   (base8      '("#faf4c6" "color-230"))
   (fg         '("#FCE8C3" "color-230"))
   (fg-alt     '("#FAF4C6" "color-230"))

   (grey         base6)
   (orange      '("#FF5F00" "color-172"))
   (orange-br   '("#FF8700" "color-172"))
   (teal        '("#008080" "color-30"))
   (dark-yellow '("#5F5F00" "color-136"))
   (dark-blue   '("#00005F" "color-17"))
   (violet      '("#008080" "color-96"))
   (dark-cyan   '("#005F5F" "color-23"))
   ;; Term colors
   (red         '("#EF2F27" "color-204"))
   (green       '("#519F50" "color-191"))
   (yellow      '("#FBB829" "color-185"))
   (blue        '("#2C78BF" "color-110"))
   (magenta     '("#E02C6D" "color-218"))
   (cyan        '("#0AAEB3" "color-159"))

   (red-br      '("#F75341" "color-204"))
   (green-br    '("#98BC37" "color-107"))
   (yellow-br   '("#FED06E" "color-185"))
   (blue-br     '("#68A8E4" "color-110"))
   (magenta-br  '("#FF5C8F" "color-218"))
   (cyan-br     '("#2BE4D0" "color-159"))

   ;; face categories
   (highlight      orange)
   (vertical-bar   base0)
   (selection      base3)
   (builtin        red)
   (comments       (if doom-srcery-brighter-comments green-br grey))
   (doc-comments   (if doom-srcery-brighter-comments (doom-lighten green-br 0.15) (doom-darken grey 0.1)))
   (constants      magenta-br)
   (functions      yellow)
   (keywords       red)
   (methods        yellow)
   (operators      fg)
   (type           blue-br)
   (strings        green-br)
   (variables      fg)
   (numbers        green-br)
   (region         base2)
   (error          red)
   (warning        orange-br)
   (success        green)
   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (hidden-alt `(,(car bg-alt) "black" "black"))
   (-modeline-pad
    (when doom-srcery-padded-modeline
      (if (integerp doom-srcery-padded-modeline) doom-sourcerer-padded-modeline 4)))

   (modeline-fg base7)
   (modeline-fg-alt (doom-blend yellow grey (if doom-srcery-brighter-modeline 0.4 0.08)))

   (modeline-bg
    (if doom-srcery-brighter-modeline
        `(,(car base4) ,@(cdr base1))
      `(,(car base3) ,@(cdr base0))))
   (modeline-bg-l
    (if doom-srcery-brighter-modeline
        modeline-bg
      `(,(doom-darken (car bg) 0.15) ,@(cdr base1))))
   (modeline-bg-inactive   (doom-darken bg 0.20))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0))))

  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background base4 :foreground base1)
   (cursor :background yellow)
   (font-lock-comment-face
    :foreground comments
    :background (if doom-srcery-comment-bg (doom-darken bg-alt 0.095)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)
   (mode-line-buffer-id :foreground green-br :bold bold)
   ((line-number &override) :foreground base6)
   ((line-number-current-line &override) :foreground base6 :bold bold)

   ((highlight &override) :foreground fg :weight 'bold :background base3)

   ((region &override) (if doom-srcery-invert-region '(:inverse-video t) `(:background ,base2)))

   (doom-modeline-bar :background (if doom-srcery-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-path :foreground (if doom-srcery-brighter-modeline fg-alt blue) :bold bold)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-project-root :foreground teal :weight 'bold)

   (tab-line :background base3)
   (tab-line-tab :background base3 :foreground fg)
   (tab-line-tab-inactive :background base3 :foreground fg-alt :box `(:line-width 1 :color ,base1 :style released-button))
   (tab-line-tab-current :background base4 :foreground fg :box `(:line-width 1 :color ,base1 :style pressed-button))
   (tab-bar :background base2)
   (tab-bar-tab :background base4 :foreground highlight)
   (tab-bar-tab-inactive :background bg-alt :foreground fg-alt)

   (mode-line
    :background base1 :foreground base7
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,base3)))
   (mode-line-inactive
    :background base1 :foreground base5
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if doom-srcery-brighter-modeline fg-alt highlight))
   (fringe :background bg)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   (lazy-highlight :foreground fg :background base4)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-property             :foreground yellow)
   (css-selector             :foreground blue)

;;;;; ivy-mode
   (ivy-current-match :background base2 :foreground fg :weight 'bold)
   (ivy-posframe :background base0 :foreground fg)

   (internal-border :background bg)

;;;;; lsp-mode and lsp-ui-mode
   (lsp-ui-doc-background :background base1)
   (lsp-ui-peek-header :foreground base7 :background base3 :bold bold)
   (lsp-ui-peek-list :inherit 'lsp-ui-dock-background)
   (lsp-ui-peek-peek :inherit 'lsp-ui-dock-background)

   ;; tooltip and company
   (tooltip              :background blue-br :foreground fg)
   (company-tooltip     :background base0)
   (company-tooltip-selection     :foreground magenta)

   ;; magit
   (magit-hash :foreground yellow)
   (magit-section-heading :foreground red)
   (magit-branch-remote :foreground orange)
   (magit-tag :foreground fg-alt)
   (magit-branch-current :foreground magenta)
   (magit-branch-local :foreground magenta-br)

   (magit-keyword :foreground green)
   (git-commit-keyword :foreground green)

   ;; markdown-mode
   (markdown-header-face :foreground base7)
   (markdown-header-face-1 :inherit 'bold :foreground blue :height (if doom-srcery-org-height 1.75 1.0))
   (markdown-header-face-2 :inherit 'bold :foreground cyan :height (if doom-srcery-org-height 1.5625 1.0))
   (markdown-header-face-3 :foreground green :height (if doom-srcery-org-height 1.25 1.0))
   (markdown-header-face-4 :foreground yellow)
   (markdown-header-face-5 :foreground blue)
   (markdown-header-face-6 :foreground cyan)

   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground base7)
   (rainbow-delimiters-depth-2-face :foreground blue-br)
   (rainbow-delimiters-depth-3-face :foreground base7)
   (rainbow-delimiters-depth-4-face :foreground cyan)
   (rainbow-delimiters-depth-5-face :foreground green)
   (rainbow-delimiters-depth-6-face :foreground blue)
   (rainbow-delimiters-depth-7-face :foreground green)
   (rainbow-delimiters-depth-8-face :foreground yellow)
;;;;; org-mode
   ((org-block &override) :foreground base7)
   ((org-block-begin-line &override) :foreground green :slant 'italic)
   ((org-block-end-line &override) :foreground green :slant 'italic)
   ((org-code &override) :foreground cyan)
   ((org-document-title &override) :foreground yellow :weight 'bold :height (if doom-srcery-org-height 1.953125 1.0))
   ((org-level-1 &override) :foreground blue-br :weight 'bold :height (if doom-srcery-org-height 1.75 1.0))
   ((org-level-2 &override) :foreground green :weight 'bold :height (if doom-srcery-org-height 1.5625 1.0))
   ((org-level-3 &override) :foreground yellow :height (if doom-srcery-org-height 1.25 1.0))
   ((org-level-4 &override) :foreground blue)
   ((org-level-5 &override) :foreground cyan)
   ((org-level-6 &override) :foreground green)
   ((org-level-7 &override) :foreground orange-br)
   ((org-level-8 &override) :foreground magenta-br)
   (org-hide :foreground hidden)
   ((org-quote &override) :inherit 'org-block :slant 'italic)
   (solaire-org-hide-face :foreground hidden-alt)

;;;;; rjsx-mode
   (rjsx-tag :foreground yellow)
   (rjsx-tag-bracket-face :foreground fg-alt)
   (rjsx-attr :foreground magenta :slant 'italic :weight 'medium)

;;;;; selectrum
   (selectrum-current-candidate :background base3 :distant-foreground base7 :weight 'normal)

;;;;; treemacs
   (treemacs-root-face :foreground strings :weight 'bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground comments)
;;;;; tree-sitter
   ;; function.call inherits from link which sets the color to 'highlight and the weight to bold. Eww
   (tree-sitter-hl-face:function.call :weight 'normal :foreground yellow)
   )


  ;; --- extra variables --------------------
  ;; ()

  )

;;; doom-srcery-theme.el ends here
