#!/usr/bin/env -S guile -s
!#
(use-modules (ice-9 popen) (ice-9 rdelim) (json))

(define (println expr)
  (display expr)
  (newline))

(define (subshell cmd)
  "Runs command CMD and returns trimmed stdout."
  (call-with-port (open-input-pipe cmd)
    (lambda (port)
      (setvbuf port 'block)
      (string-trim-both (read-delimited "" port)))))

;; (define (subshell cmd)
;;   "Runs command CMD and returns trimmed stdout."
;;   (call-with-port (open-input-pipe cmd)
;;     (lambda (port)
;;       (setvbuf port 'block)
;;       (string-trim-both (read-delimited "" port)))))

(define (swaymsg-focus-output output)
  (system (string-append "swaymsg focus output " output)))


(let* ((all-outputs (json-string->scm(subshell "swaymsg -rt get_outputs")))
       ;; (all-outputs (string-split all-outputs-str #\newline))
       (params (cdr (command-line))))
  (display all-outputs))
  ;; (when (null? params)
  ;;   (println "No params given (use 'next' or 'prev'). Exiting")
  ;;   (exit 1))
  ;; (cond
    ; is there a more elegant way, something like (safe-cadr (command-line))?
    ;; ((equal? (car params) "next") (swaymsg-focus-output (next-output all-outputs current-output)))
    ;; ((equal? (car params) "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
    ; why does (#t) not work here?
    ;; ((eq? #t #t) (println "Invalid parameter. Use 'next' or 'prev'.")))
