#!/usr/bin/env -S guile -s
!#
(use-modules (ice-9 popen) (ice-9 rdelim) (rnrs io ports))

(define (println expr)
  (display expr)
  (newline))

(define (subshell cmd)
  "Runs command CMD and returns trimmed stdout."
  (call-with-port (open-input-pipe cmd)
    (lambda (port)
      (setvbuf port 'block)
      (string-trim-both (get-string-all port)))))

;; (define (subshell cmd)
;;   "Runs command CMD and returns trimmed stdout."
;;   (let* ((port (open-input-pipe cmd))
;;          (str (read-line port)))
;;     (close-pipe port)
;;     (string-trim-both str)))

(define (next-output outputs current-output)
  ; no idea how to do circular lists yet
  (let ((safe-outputs (append outputs outputs)))
    (cadr (member current-output safe-outputs))))

(define (prev-output outputs current-output)
  (next-output (reverse outputs) current-output))

(define (swaymsg-focus-output output)
  (system (string-append "swaymsg focus output " output)))


(let* ((all-outputs-str (subshell "swaymsg -t get_outputs | jq -r '.[] | .name'"))
       (all-outputs (string-split all-outputs-str #\newline))
       (current-output (subshell "swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name'"))
       (params (cdr (command-line))))
  (when (null? params)
    (println "No params given (use 'next' or 'prev'). Exiting")
    (exit 1))
  (cond
    ; is there a more elegant way, something like (safe-cadr (command-line))?
    ((equal? (car params) "next") (swaymsg-focus-output (next-output all-outputs current-output)))
    ((equal? (car params) "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
    ; why does (#t) not work here?
    ((eq? #t #t) (println "Invalid parameter. Use 'next' or 'prev'."))))
