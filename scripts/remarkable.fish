#!/usr/bin/env fish
set rem_bin ~/code/misc/zig-rem-input/zig-out/bin/zig-rem-input
set rem_ip 0

ping -c 1 -W 1 remarkable-usb >/dev/null 2>&1

if test $status -eq 0
    set rem_ip remarkable-usb
else
    ping -c 1 -W 1 remarkable-wifi >/dev/null 2>&1
    if test $status -eq 0
        set rem_ip remarkable-wifi
    else
        printf "can't find remarkable\n"
        exit 1
    end
end

printf "remarkable is at $rem_ip\n"

printf "starting:\n"

printf "- stopping xochitl\n"
ssh root@$rem_ip 'systemctl stop xochitl'

if test $argv[1] != --pen
    printf "- forwarding touchpad\n"
    ssh root@$rem_ip 'cat /dev/input/event2' | $rem_bin touchpad &
end

if test $argv[1] != --touchpad
    printf "- forwarding pen\n"
    ssh root@$rem_ip 'cat /dev/input/event1' | $rem_bin pen &
end

printf "started!\n"

function cleanup
    printf "\n"
    printf "cleaning up:\n"

    printf "- starting xochitl\n"
    ssh root@$rem_ip 'systemctl start xochitl'

    printf "- killing zig-rem-input\n"
    pkill zig-rem-input
end

trap cleanup INT

sleep infinity
# tail -f /dev/null
