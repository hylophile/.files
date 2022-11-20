#!/usr/bin/env -S guile -s
!#
(use-modules (gus base) (ice-9 match) (grump files) (json))

(define stamp-file (expand-file-name "~/scripts/stamp"))

(define (write-stamp)
  (writeln-to-file stamp-file (current-time)))

(define (get-output)
  (let* ((stamp (string->number (string-trim-both (read-from-file stamp-file))))
         (diff  (- (current-time) stamp))
         (diff-stime (gmtime diff))
         (diff-str (strftime "%H:%M" diff-stime))
         (minutes (+ (* 60 (tm:hour diff-stime)) (tm:min diff-stime))))
    (scm->json-string (cons* `(text . ,diff-str)
                             (if (> minutes 60) '((class . warn)) '())))))

(let* ((params (cdr (command-line))))
  (match params
    (("reset") (write-stamp))
    (("print") (println (get-output)))
    (_
     (println "Invalid parameter. Use 'reset' or 'print'."))))

