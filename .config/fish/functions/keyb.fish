function keyb
setxkbmap us -device (xinput list|grep HOLDCHIP|grep -v Control -m 1|awk '{print $6}'|sed 's/id=//')
end
