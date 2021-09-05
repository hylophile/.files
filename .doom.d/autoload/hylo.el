;;; autoload/hylo.el -*- lexical-binding: t; -*-

;;;###autoload
(defun hylo/random-non-light-theme ()
  (let ((theme (seq-random-elt (seq-remove
                                (lambda (x)
                                  (or (string-suffix-p "-light" (symbol-name x))
                                      (string-prefix-p "light-" (symbol-name x))))
                                (custom-available-themes)))))
    (message (symbol-name theme))
    theme))

;; (defun hylo/insert-theme () (insert (symbol-name doom-theme)))

;;;###autoload
(defun hylo/insert-theme ()
  (insert
   "\n"
   (+doom-dashboard--center
    (- +doom-dashboard--width 2)
    (with-temp-buffer
      (insert (symbol-name doom-theme))
      (buffer-string)))
   "\n"))
