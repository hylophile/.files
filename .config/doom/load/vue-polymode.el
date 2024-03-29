;;; load/vue-polymode.el -*- lexical-binding: t; -*-

(use-package! polymode
        :defer t
        :hook (vue-mode . lsp-deferred)
        :mode ("\\.vue\\'" . vue-mode)
        :config
        (define-innermode poly-vue-template-innermode
          :mode 'html-mode
          :head-matcher "^<[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :tail-matcher "^</[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-script-innermode
          :mode 'rjsx-mode
          :head-matcher "<[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :tail-matcher "</[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-template-tag-lang-innermode
          :head-matcher "^<[[:space:]]*\\(?:template\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "^</[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :mode-matcher (cons  "^<[[:space:]]*\\(?:template\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-script-tag-lang-innermode
          :head-matcher "<[[:space:]]*\\(?:script\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*\\(?:script\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*[[:alpha:]]*[[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-style-tag-lang-innermode
          :head-matcher "<[[:space:]]*\\(?:style\\)\\(?:scoped\\|[[:space:]]\\)*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"']*\\(?:scoped\\|[[:space:]]\\)*>"
          :tail-matcher "</[[:space:]]*\\(?:style\\)[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*\\(?:style\\)\\(?:scoped\\|[[:space:]]\\)*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"']\\(?:scoped\\|[[:space:]]\\)*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-style-innermode
          :mode 'css-mode
          :head-matcher "<[[:space:]]*\\(?:style\\)[[:space:]]*\\(?:scoped\\|[[:space:]]\\)*>"
          :tail-matcher "</[[:space:]]*\\(?:style\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-polymode vue-mode
          :hostmode 'poly-sgml-hostmode
          :innermodes '(
                        poly-vue-template-tag-lang-innermode
                        poly-vue-script-tag-lang-innermode
                        poly-vue-style-tag-lang-innermode
                        poly-vue-template-innermode
                        poly-vue-script-innermode
                        poly-vue-style-innermode
                        )))
