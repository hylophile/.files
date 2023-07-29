#!/usr/bin/env sh
pactl list short sources | awk -v state=$1 '{system("pactl set-source-mute " $1 " " state)}'
