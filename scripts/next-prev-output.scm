#!/usr/bin/env -S guile -s
!#
(use-modules (gus base) (ice-9 match))

(define sway-outputs (vector->list (subjson "swaymsg -t get_outputs")))

(define current-output
  (cdr (assoc "name" (car (filter
                           (lambda (e) (eq? #t (cdr (assoc "focused" e))))
                           sway-outputs)))))

(define all-outputs
  (map (lambda (e) (cdr (assoc "name" e))) sway-outputs))

(define (next-output outputs current-output)
  ; no idea how to do circular lists yet
  (let ((safe-outputs (append outputs outputs)))
    (cadr (member current-output safe-outputs))))

(define (prev-output outputs current-output)
  (next-output (reverse outputs) current-output))

(define (swaymsg-focus-output output)
  (system (string-append "swaymsg focus output " output)))

(let* ((params (cdr (command-line))))
  (match params
    (("next") (swaymsg-focus-output (next-output all-outputs current-output)))
    (( "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
    ; why does (#t) not work here?
    (_
     (println "Invalid parameter. Use 'next' or 'prev'."))))
