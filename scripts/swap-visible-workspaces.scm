#!/usr/bin/env -S guile -s
!#
(use-modules (gus base))

(define workspaces
    (vector->list (subjson "swaymsg -t get_workspaces")))

(define visible-workspaces
  (filter (lambda (e) (eq? #t (cdr (assoc "visible" e))))
        workspaces))

(define visible-workspaces-nums
  (map (lambda (w) (cdr (assoc "num" w))) visible-workspaces))

(define current-workspace-num
  (cdr (assoc "num"
              (car (filter
                    (lambda (e) (eq? #t (cdr (assoc "focused" e))))
                    visible-workspaces)))))

(for-each (lambda (ws)
                 (system (string-append "swaymsg \"workspace --no-auto-back-and-forth " (number->string ws) "\""))
                 (system "swaymsg move workspace to output left"))
        visible-workspaces-nums)

(system (string-append "swaymsg \"workspace --no-auto-back-and-forth " (number->string current-workspace-num) "\""))
(system "swaymsg focus output left")
