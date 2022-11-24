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

(define bgs (list->vector (string-split (subshell "fd . /media/wallpapers/all") #\newline)))

(define (rrr n)
  (random n (seed->random-state (cdr (gettimeofday)))))

(define (random-bg)
  (vector-ref bgs (rrr (vector-length bgs))))

(define (set-random-bg-for-output output)
  (system (string-append "swww img --transition-step 10 --outputs " output " " (random-bg))))

(let* ((params (cdr (command-line))))
  (match params
    (("here") (set-random-bg-for-output current-output))
    (("all") (for-each set-random-bg-for-output all-outputs))
    (_
     (println "Invalid parameter. Use 'here' or 'all'."))))
