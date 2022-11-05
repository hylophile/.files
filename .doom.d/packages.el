;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)
;; (package! vue-mode)
;; (package! polymode)
(package! prism :recipe (:host github :repo "alphapapa/prism.el"))
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! svelte-mode :recipe (:host github :repo "leafoftree/svelte-mode"))
(package! org-super-agenda)
(package! websocket)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(package! lsp-volar :recipe (:host github :repo "jadestrong/lsp-volar"))
;; (package! web-mode :recipe (:local-repo "~/.doom.d/p/web-mode"))
;;(package! ein :pin "e354ea77c29e8c20b6b1a9ee00d86e6a9512bc0d")
(unpin! web-mode)

(unpin! ace-window)
;;(package! everforest-hard-dark-theme
;;  :recipe (:repo "https://git.sr.ht/~theorytoe/everforest-hard-dark-theme"))
(package! affe)
;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
;(package! everforest-harder-theme
;  :recipe (:local-repo "~/.doom.d/packages/ever"))

(package! ef-themes :recipe (:local-repo "~/code/doom-ef-themes/" :build (:not compile)))

(package! page-break-lines)
(package! minibuffer-header)

(package! tempel)
;; (package! ef-themes :recipe (:host nil :repo "https://git.sr.ht/~protesilaos/ef-themes"))

(package! vundo :recipe (:host github :repo "casouri/vundo"))

;; (package! spookfox :recipe (:host github :repo "bitspook/spookfox" :files ("lisp/*.el" "lisp/apps/*.el")))

;; (package! cape-yasnippet :recipe (:host github :repo "elken/cape-yasnippet"))

(package! eldoc-box)
(package! org-fancy-priorities :disable t)
;; (package! org-modern)
(package! org-appear :recipe (:host github :repo "awth13/org-appear"))

;; (package! company-quickhelp)
;; (unpin! company-box)
(package! apheleia)




(unpin! vterm)
(unpin! lsp-mode)
;; (unpin! lsp-dart)
(unpin! forge)
(when (featurep! :completion corfu)
  (unpin! evil-collection))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
