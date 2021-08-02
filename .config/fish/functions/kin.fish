function kin
setxkbmap de neo -device (xinput list|awk '/Kinesis/ && !/Control/ {print $6}'|sed 's/id=//')
end
