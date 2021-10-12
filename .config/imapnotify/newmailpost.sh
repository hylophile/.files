#!/usr/bin/env bash

/usr/bin/emacsclient -e '(mu4e-update-index)'
notify-send 'New mail arrived.' "($1)" --icon=mail-unread-symbolic
