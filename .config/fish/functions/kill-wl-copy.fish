function kill-wl-copy
while pidof wl-copy
for p in (string split ' ' (pidof wl-copy))
echo killing $p
kill $p
end
sleep 0.1
end
end
