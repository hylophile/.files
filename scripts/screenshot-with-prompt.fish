#!/usr/bin/env fish

set screenshots (ls ~/screenshots/*.png | xargs -n1 basename --suffix=".png")
set name (echo $screenshots | rofi -dmenu -sep ' ' -title "Taking a screenshot." -p "Filename: ~/screenshots/")
if test -z $name
    exit
end
set name "$HOME/screenshots/$name.png"

grim -g "$(slurp)" "$name"

wl-copy "$name"

set view (notify-send "Screenshot '$(wl-paste)' saved. (Middle-click to view)" --action=view=view)
if test -n "$view"; and test $view = view
    imv $(wl-paste)
end
