(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((elisp-lint-indent-specs (git-gutter:awhen . 1))))
 '(package-selected-packages '(eldoc-box))
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
      (cmd!
       (ignore-errors
         (org-babel-execute-buffer)))
      t t)
     (eval add-hook 'after-save-hook #'org-babel-tangle t t)
     (eval add-hook 'after-save-hook #'org-babel-execute-buffer t t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(+workspace-tab-face ((t (:inherit default :family "Jost*" :height 135))))
 '(+workspace-tab-selected-face ((t (:inherit (highlight +workspace-tab-face)))))
 '(aw-leading-char-face ((t (:foreground unspecified :background "#90e8b0" :weight bold :height 1.0 :box (:line-width -50 :color "#90e8b0")))))
 '(font-lock-comment-face ((t (:slant italic :weight normal))))
 '(nav-flash-face ((t (:background "#33bfff" :foreground "#0f172a"))))
 '(org-agenda-diary ((t (:foreground nil :weight bold))))
 '(org-document-title ((t (:height 1.5))))
 '(outline-1 ((t (:weight semi-bold :height 1.15))))
 '(outline-2 ((t (:weight semi-bold :height 1.1))))
 '(outline-3 ((t (:weight semi-bold :height 1.09))))
 '(outline-4 ((t (:weight semi-bold :height 1.06))))
 '(outline-5 ((t (:weight semi-bold :height 1.03))))
 '(outline-6 ((t (:weight semi-bold :height 1.0))))
 '(outline-7 ((t (:weight semi-bold :height 1.0))))
 '(outline-8 ((t (:weight semi-bold))))
 '(outline-9 ((t (:weight semi-bold))))
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'narrow-to-page 'disabled nil)
