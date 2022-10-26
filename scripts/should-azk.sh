#!/usr/bin/env sh

whoami | grep nsa
nr=$?
! nmcli | grep 'wlp3s0: connected to eduroam'
edr=$?

[ $nr = 0 ] && [ $edr = 0 ]
