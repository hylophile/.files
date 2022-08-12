#!/usr/bin/env sh

if nmcli -f GENERAL.STATE connection show work | grep activated;
then
    nmcli --ask connection down id work
else
    nmcli connection up id work
fi
