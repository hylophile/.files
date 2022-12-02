#!/usr/bin/env -S guile -s
!#
(use-modules (gus base) (ice-9 match))

(define sway-outputs (vector->list (subjson "swaymsg -t get_outputs")))

(define all-outputs
  (map (lambda (e) (cdr (assoc "name" e))) sway-outputs))

(and (eq? 3 (length all-outputs)) (member "eDP-1" all-outputs) (system "swaymsg output eDP-1 scale 1.5"))
