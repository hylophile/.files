#!/usr/bin/env -S guile -s
!#
(use-modules (gus base) (ice-9 match))

(define workspaces
  (map (lambda (w) (cdr (assoc "num" w)))
    (vector->list(subjson "swaymsg -t get_workspaces"))))

(define new-workspace (1+ (apply max workspaces)))

(let* ((params (cdr (command-line))))
  (match params
    (("focus")
     (system (string-append
              "swaymsg workspace "
              (number->string new-workspace))))
    (("move-to")
     (system (string-append
              "swaymsg move container to workspace number "
              (number->string new-workspace))))
    (_
     (println "No params given / param unknown.\nUse 'focus' or 'move-to'."))))
