function windows
    # for grub
    # set windows_title (sudo grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)
    # sudo grub-reboot $windows_title
    # systemctl reboot

    # for systemd-boot
    sudo bootctl set-oneshot auto-windows
    systemctl reboot
end
