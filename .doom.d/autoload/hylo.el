;;; autoload/hylo.el -*- lexical-binding: t; -*-

;;;###autoload
(defun hylo/random-dark-theme ()
  (let ((theme (seq-random-elt (hylo/likeable-dark-themes))))
    (message (symbol-name theme))
    theme))


;;;###autoload
(defun hylo/likeable-dark-themes ()
  (seq-remove
   (lambda (x)
     (or
      (eval
       (cons 'or
             (mapcar (lambda (y) (string=
                                  (symbol-name x)
                                  (symbol-name y)))
                     '(
                       ;; undesirable
                       manoj-dark
                       doom-plain-dark
                       wombat
                       ;; light
                       light-blue
                       doom-flatwhite
                       whiteboard
                       doom-plain))))
      (string-suffix-p "-light" (symbol-name x))))
   (custom-available-themes)))

;;;###autoload
(defun hylo/insert-theme ()
  (insert
   (+doom-dashboard--center
    +doom-dashboard--width
    (concat
     (propertize
      "Theme loaded: "
      'face 'doom-dashboard-menu-title)
     (propertize (symbol-name doom-theme)
                 'face '(:inherit (doom-dashboard-menu-desc bold)))))
   "\n\n"))
