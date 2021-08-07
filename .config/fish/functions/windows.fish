function windows
set windows_title (sudo grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)
sudo grub-reboot $windows_title
systemctl reboot
end
