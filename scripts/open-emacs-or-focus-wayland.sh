#!/usr/bin/env sh

if ! swaymsg '[app_id="^emacs$"]' focus; then
    emacs &
fi
