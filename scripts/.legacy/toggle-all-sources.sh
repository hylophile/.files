#!/usr/bin/env bash
default_source=$(pactl get-default-source)
is_on=$(pactl list sources | grep -A 10 $default_source | grep "Mute: no")

toggle_all()
{
    pactl list short sources | awk -v state=$1 '{system("pactl set-source-mute " $1 " " state)}'
}

if [ "$is_on" = "" ];
then
    toggle_all 'off'
else
    toggle_all 'on'
fi
