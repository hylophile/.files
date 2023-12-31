{ config, lib, pkgs, ... }:

{
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="666", GROUP="plugdev"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="666", GROUP="plugdev"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", MODE="666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", MODE="666", GROUP="plugdev"
  '';
}
