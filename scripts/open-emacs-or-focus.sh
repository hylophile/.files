#!/usr/bin/env sh

if ! i3-msg '[class="^Emacs$"]' focus; then
    ~/.nix-profile/bin/emacs &
fi
