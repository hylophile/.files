;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

(package! org :recipe
  (:host nil :repo "https://git.tecosaur.net/mirrors/org-mode.git" :remote "mirror" :fork
   (:host nil :repo "https://git.tecosaur.net/tec/org-mode.git" :branch "dev" :remote "tecosaur")
   :files
   (:defaults "etc")
   :build t :pre-build
   (with-temp-file "org-version.el"
     (require 'lisp-mnt)
     (let
         ((version
           (with-temp-buffer
             (insert-file-contents "lisp/org.el")
             (lm-header "version")))
          (git-version
           (string-trim
            (with-temp-buffer
              (call-process "git" nil t nil "rev-parse" "--short" "HEAD")
              (buffer-string)))))
       (insert
        (format "(defun org-release () \"The release version of Org.\" %S)\n" version)
        (format "(defun org-git-version () \"The truncate git commit hash of Org mode.\" %S)\n" git-version)
        "(provide 'org-version)\n"))))
  :pin nil)

(unpin! org)

(package! syntax-subword)


(package! keycast)
(package! corfu-candidate-overlay :recipe (:host nil :repo "https://code.bsdgeek.org/adam/corfu-candidate-overlay"
                                           :files (:defaults "*.el")))
;; (package! completion-preview :recipe (:host nil :repo "https://git.sr.ht/~eshel/completion-preview"))



;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)
;; (package! vue-mode)
;; (package! polymode)
;; (package! prism :recipe (:host github :repo "alphapapa/prism.el"))
;; (package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! svelte-mode :recipe (:host github :repo "leafoftree/svelte-mode"))
(package! org-super-agenda)
;; (package! websocket)
;; (package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
;; (package! lsp-volar :recipe (:host github :repo "jadestrong/lsp-volar"))
;; (package! web-mode :recipe (:local-repo "~/.doom.d/p/web-mode"))
;;(package! ein :pin "e354ea77c29e8c20b6b1a9ee00d86e6a9512bc0d")
;; (unpin! web-mode)
(package! transpose-frame)
(unpin! ace-window)
;;(package! everforest-hard-dark-theme
;;  :recipe (:repo "https://git.sr.ht/~theorytoe/everforest-hard-dark-theme"))
;; (package! affe)
;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))
                                        ;(package! everforest-harder-theme
                                        ;  :recipe (:local-repo "~/.doom.d/packages/ever"))

;; (package! emacs-everywhere :recipe (:local-repo "~/code/emacs-everywhere/" :build (:not compile)))
;; (package! ef-themes :recipe (:local-repo "~/code/misc/doom-ef-themes/" :build (:not compile)))
(package! ef-themes :recipe (:host nil :repo "https://git.sr.ht/~protesilaos/ef-themes"))
(package! page-break-lines)
(package! minibuffer-header)

;; (package! tempel)

;; (package! vundo :recipe (:host github :repo "casouri/vundo"))

;; (package! spookfox :recipe (:host github :repo "bitspook/spookfox" :files ("lisp/*.el" "lisp/apps/*.el")))

;; (package! cape-yasnippet :recipe (:host github :repo "elken/cape-yasnippet"))

(package! eldoc-box)
(package! org-fancy-priorities :disable t)
(package! org-modern)
(package! org-appear :recipe (:host github :repo "awth13/org-appear"))


(package! git-auto-commit-mode)
;; (package! company-quickhelp)
;; (unpin! company-box)
;; (package! apheleia)

;; (package! exercism-modern
;;   :recipe (:files (:defaults "icons")
;;            :host github :repo "elken/exercism-modern"))

;; (package! engrave-faces :recipe (:host github :repo "tecosaur/engrave-faces"))

;; (unpin! persp-mode)
;; (package! writeroom-mode)
(package! visual-fill-column)
(package! mixed-pitch)

(package! rg)
(package! dts-mode)
;; (package! flymake-vale :recipe (:host github :repo "tpeacock19/flymake-vale"))
;; adds popups, optional but reccomened
;; (package! flymake-popon :recipe (:repo "https://codeberg.org/akib/emacs-flymake-popon"))

(package! git-link)

;; (package! singularity-mode :recipe (:host github :repo "karljohanw/singularity-mode"))
;; (package! org-timeblock :recipe (:host github :repo "ichernyshovvv/org-timeblock"))
(package! org-timeblock :recipe (:local-repo "~/code/misc/org-timeblock/" :build (:not compile)))

;; (package! gptel)
;; (package! olivetti)

(unpin! vterm)
(unpin! lsp-mode)
;; (unpin! lsp-dart)
;; (unpin! forge)
;; (when (featurep! :completion corfu)
;;   (unpin! evil-collection))

(package! idris2 :recipe (:host github :repo "jeroendehaas/idris2-mode" :branch "fix-completion-error"))
(package! prop-menu)

;; (package! meow)
(package! meow :recipe (:local-repo "~/code/meow/" :build (:not compile)))
(package! visual-regexp)
(package! embrace)

(package! macrursors :recipe (:host github :repo "corytertel/macrursors"))

(package! easy-kill)
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
(package! yuck-mode)
