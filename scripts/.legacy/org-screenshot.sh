#!/usr/bin/env bash
set -e

filename="$(date +%Y-%m-%d-%s.png)"
orgpath="~/org/img/$filename"
maimpath="$HOME/org/img/$filename"

maim -s $maimpath && echo "[[file:$orgpath]]" | xclip -selection primary
