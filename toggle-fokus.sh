if nmcli -f GENERAL.STATE con show work | grep activated;
then
    nmcli --ask con down id work
else
    nmcli con up id work
fi
