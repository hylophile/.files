#!/usr/bin/env bash
set -e

filename="$(date +%Y-%m-%d-%s.png)"
orgpath="img/$filename"
fullpath="$HOME/org/$orgpath"

maim -s $fullpath && echo "[[file:$orgpath]]" | xclip -selection primary
