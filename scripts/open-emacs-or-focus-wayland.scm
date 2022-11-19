#!/usr/bin/env -S guile -s
!#

(unless (eq? 0 (system "swaymsg '[app_id=\"^emacs$\"]' focus"))
  (system "emacs &"))
