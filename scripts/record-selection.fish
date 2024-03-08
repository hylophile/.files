#!/usr/bin/env fish

if pgrep wf-recorder
    pkill wf-recorder --signal SIGINT
    notify-send "Recording stopped."
    sleep 1
    set view (notify-send "Recording of '$(wl-paste)' saved. (Middle-click to view)" --action=view=view)
    if test $view = view
        mpv $(wl-paste)
    end
else
    set recordings (ls ~/recordings/*.mp4 | xargs -n1 basename --suffix=".mp4")
    set name (echo $recordings | rofi -dmenu -sep ' ' -title "Recording a selection." -p "Filename: ~/recordings/")
    if test -z $name
        exit
    end
    set name "$HOME/recordings/$name.mp4"

    echo Y | wf-recorder -g "$(slurp)" --pixel-format yuv420p --file=$name

    wl-copy "$name"
end
