;;; fancy-splash.el --- Generated package (no.6) from my config -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 TEC
;;
;; Author: TEC <https://git.tecosaur.net/tec>
;; Maintainer: TEC <contact@tecosaur.net>
;; Created: October 27, 2022
;; Modified: October 27, 2022
;; Version: 2022.10.27
;; Homepage: https://git.tecosaur.net/tec/emacs-config
;; Package-Requires: ((emacs "27.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Generated package (no.6) from my config.
;;
;;  This is liable to have unstated dependencies, and reply on other bits of
;;  state from other configuration blocks. Only use this if you know /exactly/
;;  what you are doing.
;;
;;  This may function nicely as a bit of self-contained functionality, or it
;;  might be a horrid mix of functionalities and state.
;;
;;  Hopefully, in future static analysis will allow this to become more
;;  properly package-like.
;;
;;; Code:

(defvar fancy-splash-image-directory
  (expand-file-name "misc/splash-images/" doom-private-dir)
  "Directory in which to look for splash image templates.")

(defvar fancy-splash-image-template
  (expand-file-name "emacs-e-template.svg" fancy-splash-image-directory)
  "Default template svg used for the splash image.
Colours are substituted as per `fancy-splash-template-colours'.")
(defvar fancy-splash-template-colours
  '(("#000001" :face ansi-color-black)
    ("#111112" :face font-lock-keyword-face)
    ("#222223" :face font-lock-type-face)
    ("#333334" :face font-lock-constant-face)
    ("#444445" :face font-lock-function-name-face)
    ("#555556" :face font-lock-string-face)
    ("#666667" :face error)
    ("#ff0000" :face ansi-color-red)
    ("#00ff00" :face ansi-color-green)
    ("#0000ff" :face ansi-color-blue)
    ("$ddddde" :face shadow)
    ("#eeeeef" :face ansi-color-bright-white)
    ("#fffff1" :face ansi-color-white))
  "Alist of colour-replacement plists.
Each plist is of the form (\"$placeholder\" :doom-color 'key :face 'face).
If the current theme is a doom theme :doom-color will be used,
otherwise the colour will be face foreground.")
(defvar fancy-splash-cache-dir (expand-file-name "theme-splashes/" doom-cache-dir))
(defvar fancy-splash-sizes
  `((:height 300 :min-height 50 :padding (0 . 2))
    (:height 250 :min-height 42 :padding (2 . 4))
    (:height 200 :min-height 35 :padding (3 . 3))
    (:height 150 :min-height 28 :padding (3 . 3))
    (:height 100 :min-height 20 :padding (2 . 2))
    (:height 75  :min-height 15 :padding (2 . 1))
    (:height 50  :min-height 10 :padding (1 . 0))
    (:height 1   :min-height 0  :padding (0 . 0)))
  "List of plists specifying image sizing states.
Each plist should have the following properties:
- :height, the height of the image
- :min-height, the minimum `frame-height' for image
- :padding, a `+doom-dashboard-banner-padding' (top . bottom) padding
  specification to apply
Optionally, each plist may set the following two properties:
- :template, a non-default template file
- :file, a file to use instead of template")
(defun fancy-splash-filename (theme template height)
  "Get the file name for the splash image with THEME and of HEIGHT."
  (expand-file-name (format "%s-%s-%d.svg" theme (file-name-base template) height) fancy-splash-cache-dir))
(defun fancy-splash-generate-image (template height)
  "Create a themed image from TEMPLATE of HEIGHT.
The theming is performed using `fancy-splash-template-colours'
and the current theme."
  (with-temp-buffer
    (insert-file-contents template)
    (if (re-search-forward "$height" nil t)
        (replace-match (number-to-string height) nil nil)
      (warn "fancy splash template problem: $height not found in %s" template))
    (dolist (substitution fancy-splash-template-colours)
      (goto-char (point-min))
      (let ((replacement
               (face-attribute (plist-get (cdr substitution) :face)
                               :foreground nil 'default)))
        (while (search-forward (car substitution) nil t)
          (replace-match replacement nil nil))))
    (unless (file-exists-p fancy-splash-cache-dir)
      (make-directory fancy-splash-cache-dir t))
    (write-region nil nil (fancy-splash-filename (car custom-enabled-themes) template height) nil nil)))
(defun fancy-splash-generate-all-images ()
  "Perform `fancy-splash-generate-image' in bulk."
  (dolist (size fancy-splash-sizes)
    (unless (plist-get size :file)
      (fancy-splash-generate-image
       (or (plist-get size :template)
           fancy-splash-image-template)
       (plist-get size :height)))))
(defun fancy-splash-ensure-theme-images-exist (&optional height)
  "Ensure that the relevant images exist.
Use the image of HEIGHT to check, defaulting to the height of the first
specification in `fancy-splash-sizes'. If that file does not exist for
the current theme, `fancy-splash-generate-all-images' is called. "
  (unless (file-exists-p
           (fancy-splash-filename
            (car custom-enabled-themes)
            fancy-splash-image-template
            (or height (plist-get (car fancy-splash-sizes) :height))))
    (fancy-splash-generate-all-images)))
(defun fancy-splash-clear-cache (&optional delete-files)
  "Clear all cached fancy splash images.
Optionally delete all cache files and regenerate the currently relevant set."
  (interactive (list t))
  (dolist (size fancy-splash-sizes)
    (unless (plist-get size :file)
      (let ((image-file
             (fancy-splash-filename
              (car custom-enabled-themes)
              (or (plist-get size :template)
                  fancy-splash-image-template)
              (plist-get size :height))))
        (image-flush (create-image image-file) t))))
  (message "Fancy splash image cache cleared!")
  (when delete-files
    (delete-directory fancy-splash-cache-dir t)
    (fancy-splash-generate-all-images)
    (message "Fancy splash images cache deleted!")))
(defun fancy-splash-switch-template ()
  "Switch the template used for the fancy splash image."
  (interactive)
  (let ((new (completing-read
              "Splash template: "
              (mapcar
               (lambda (template)
                 (replace-regexp-in-string "-template\\.svg$" "" template))
               (directory-files fancy-splash-image-directory nil "-template\\.svg\\'"))
              nil t)))
    (setq fancy-splash-image-template
          (expand-file-name (concat new "-template.svg") fancy-splash-image-directory))
    (fancy-splash-clear-cache)
    (message "") ; Clear message from `fancy-splash-clear-cache'.
    (setq fancy-splash--last-size nil)
    (fancy-splash-apply-appropriate-image)))
(defun fancy-splash-get-appropriate-size ()
  "Find the firt `fancy-splash-sizes' with min-height of at least frame height."
  (let ((height (frame-height)))
    (cl-some (lambda (size) (when (>= height (plist-get size :min-height)) size))
             fancy-splash-sizes)))
(setq fancy-splash--last-size nil)
(setq fancy-splash--last-theme nil)

(defun fancy-splash-apply-appropriate-image (&rest _)
  "Ensure the appropriate splash image is applied to the dashboard.
This function's signature is \"&rest _\" to allow it to be used
in hooks that call functions with arguments."
  (let ((appropriate-size (fancy-splash-get-appropriate-size)))
    (unless (and (equal appropriate-size fancy-splash--last-size)
                 (equal (car custom-enabled-themes) fancy-splash--last-theme))
      (unless (plist-get appropriate-size :file)
        (fancy-splash-ensure-theme-images-exist (plist-get appropriate-size :height)))
      (setq fancy-splash-image
            (or (plist-get appropriate-size :file)
                (fancy-splash-filename (car custom-enabled-themes)
                                       fancy-splash-image-template
                                       (plist-get appropriate-size :height)))
            +doom-dashboard-banner-padding (plist-get appropriate-size :padding)
            fancy-splash--last-size appropriate-size
            fancy-splash--last-theme (car custom-enabled-themes))
      (+doom-dashboard-reload))))

(provide 'fancy-splash)
;;; fancy-splash.el ends here
