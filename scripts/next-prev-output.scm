#!/usr/bin/env -S guile -s
!#
(use-modules (ice-9 popen) (ice-9 rdelim) (rnrs io ports))

;; (import (ice-9 rdelim) (ice-9 popen) (rnrs io ports))

;; (define (call-command-with-output-error-to-string cmd)
;;   (let* ((err-cons (pipe))
;;          (port (with-error-to-port (cdr err-cons)
;;                  (λ() (open-input-pipe cmd))))
;;          (_ (setvbuf (car err-cons) 'block
;;              (* 1024 1024 16)))
;;          (result (read-delimited "" port)))
;;     (close-port (cdr err-cons))
;;     (values
;;      result
;;      (read-delimited "" (car err-cons)))))

;; (call-command-with-output-error-to-string "echo 1; echo 2 >&2")

;; (define-syntax-rule (log-exprs exp ...) (begin (format #t "~a: ~S\n" (quote exp) exp) ...))
(define (println expr)
  (display expr)
  (newline))

;; (define (subshell cmd)
;;   "Runs command CMD and returns trimmed stdout."
;;   (call-with-port (open-input-pipe cmd)
;;     (lambda (port)
;;       (setvbuf port 'block)
;;       (get-string-all port)))
;;     )

;; (let ((commands '(("git" "ls-files")
;;                   ("tar" "-cf-" "-T-")
;;                   ("sha1sum" "-")))
;;       (success? (lambda (pid)
;;                   (zero?
;;                    (status:exit-val (cdr (waitpid pid)))))))
;;   (receive (from to pids) (pipeline commands)
;;     (let* ((sha1 (read-delimited " " from))
;;            (index (list-index (negate success?) (reverse pids))))
;;       (close to)
;;       (close from)
;;       (if (not index)
;;           sha1
;;           (string-append "pipeline failed in command: "
;;                          (string-join (list-ref commands index)))))))

;; (newline)
    (define (wg-gen-public-key private-key)
      (call-with-values (lambda () (pipeline '(("ls"))))
        (lambda (from to pids)
          ;; (display private-key to)
          (close-port to)
          (let ((result (read-line from)))
            (close-port from)
            ;; Reap the process and check its status.
            ;; (match-let* (((pid) pids)
            ;;              ((_ . status) (waitpid pid)))
            ;;   (unless (zero? (status:exit-val status))
            ;;     (error "could not generate public key")))
            result))))

(display (wg-gen-public-key "a"))
;; (let* ( (connect-pipe (pipe))
;;         (reader-pipe  (car connect-pipe))
;;         (writer-pipe  (cdr connect-pipe))
;;         (child-pid    (primitive-fork)) )

;;   (if (= child-pid 0)
;;       (begin

;;         (close-input-port reader-pipe)
;;         (display (string-append "inside child, pid = "
;;                          (number->string (getpid))  ))
;;         (newline)
;;         (display (string-append "(child pid "
;;                          (number->string (getpid))
;;                          " is sending this)\n" )
;;                  writer-pipe )
;;         (close-output-port writer-pipe) )

;;       (begin

;;         (close-output-port writer-pipe)
;;         (display (string-append "inside parent, pid = "
;;                          (number->string (getpid))
;;                          ", child pid = "
;;                          (number->string child-pid) ))
;;         (newline)
;;         (display (string-append "reading from child: " (read-line reader-pipe)))
;;         (close-input-port reader-pipe)
;;         (waitpid child-pid 0) )))



(define (subshell cmd)
  "Runs command CMD and returns trimmed stdout."
  (let* ((port (open-input-pipe cmd))
         (str (read-line port)))
    (close-pipe port)
    (string-trim-both str)))

;; (display (subshell "ls"))

(define (next-output outputs current-output)
  ; no idea how to do circular lists yet
  (let ((safe-outputs (append outputs outputs)))
    (cadr (member current-output safe-outputs))))

(define (prev-output outputs current-output)
  (next-output (reverse outputs) current-output))

(define (swaymsg-focus-output output)
  (system (string-append "swaymsg focus output " output)))


(let* (
       ;; (all-outputs-str (subshell "swaymsg -t get_outputs | jq -r '.[] | .name'"))
       ;; (all-outputs (string-split all-outputs-str #\newline))
       ;; (current-output (subshell "swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name'"))
       (params (cdr (command-line))))
  (when (null? params)
    (println "No params given (use 'next' or 'prev'). Exiting")
    (exit 1))
  (cond
    ; is there a more elegant way, something like (safe-cadr (command-line))?
    ;; ((equal? (car params) "next") (swaymsg-focus-output (next-output all-outputs current-output)))
    ;; ((equal? (car params) "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
    ; why does (#t) not work here?
    ((eq? #t #t) (println "Invalid parameter. Use 'next' or 'prev'."))))
