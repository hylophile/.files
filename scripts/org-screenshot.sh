#!/usr/bin/env bash
set -euxo

filename="$(date +%Y-%m-%d-%s.png)"
orgpath="img/$filename"
fullpath="$HOME/org/$orgpath"

grim -g "$(slurp)" "$fullpath"
wl-copy "[[file:~/org/$orgpath]]"
wl-copy --primary "[[file:~/org/$orgpath]]"
