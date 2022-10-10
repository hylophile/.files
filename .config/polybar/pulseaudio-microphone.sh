#!/bin/sh

status() {
    # pamixer --get-volume-human --default-source
    if [ "$(pamixer --get-mute --default-source)" = "true" ]; then
      echo "%{F#ff5555}%{B#282a36} %{T2} "
    else
      echo "%{F#50fa7b}%{B#282a36} %{T2} "
      # echo "$(pamixer --get-volume-human --default-source)"
    fi
}

listen() {
    status

    LANG=EN; pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
            status
        fi
    done
}

toggle() {
  pamixer --toggle-mute --default-source
}

increase() {
  pactl set-source-volume @DEFAULT_SOURCE@ +5%
}

decrease() {
  pactl set-source-volume @DEFAULT_SOURCE@ -5%
}

case "$1" in
    --toggle)
        toggle
        ;;
    --increase)
        increase
        ;;
    --decrease)
        decrease
        ;;
    *)
        listen
        ;;
esac
