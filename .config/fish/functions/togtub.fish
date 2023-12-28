function togtub
    set vpn_name TUB
    set vpn_status (nmcli connection show "$vpn_name" | grep "GENERAL.STATE" | awk '{print $2}')
    if test "$vpn_status" = activated
        nmcli connection down "$vpn_name"
        echo "VPN deactivated: $vpn_name"
    else
        nmcli connection up "$vpn_name"
        echo "VPN activated: $vpn_name"
    end
end
