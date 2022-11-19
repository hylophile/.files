#!/usr/bin/env -S guile -s
!#
(use-modules (gus base))

(define sway-outputs (vector->list (subjson "swaymsg -t get_outputs")))

(define current-output
  (cdr (assoc "name" (car (filter (lambda (e) (assoc "focused" e)) sway-outputs)))))

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
  (when (null? params)
    (println "No params given (use 'next' or 'prev'). Exiting")
    (exit 1))
  (cond
    ; is there a more elegant way, something like (safe-cadr (command-line))?
    ((equal? (car params) "next") (swaymsg-focus-output (next-output all-outputs current-output)))
    ((equal? (car params) "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
    ; why does (#t) not work here?
    ((eq? #t #t) (println "Invalid parameter. Use 'next' or 'prev'."))))
