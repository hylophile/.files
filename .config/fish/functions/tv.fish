function tv
    set -l name $(swaymsg -t get_outputs | jq -r '.[] | select(.model=="SAMSUNG") .name')
    switch $argv[1]
        case on
            swaymsg output $name enable
        case off
            swaymsg output $name disable
        case 4k60
            swaymsg output $name mode 3840x2160@60Hz
        case 4k30
            swaymsg output $name mode 3840x2160@30Hz
        case 1k
            swaymsg output $name mode 1920x1080@60Hz
        case zoom
            swaymsg output $name scale $argv[2]
        case t
            tv toggle
        case toggle
            set -l active $(swaymsg -t get_outputs | jq -r '.[] | select(.model=="SAMSUNG") .active')
            if [ $active = false ]
                tv on && tv 4k60
            else
                tv off
            end
    end
end
