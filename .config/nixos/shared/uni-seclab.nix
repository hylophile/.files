{
  config,
  lib,
  pkgs,
  ...
}: {
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="666", GROUP="plugdev"
  #   SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="666", GROUP="plugdev"
  #   SUBSYSTEM=="tty", ATTRS{idVendor}=="1366", MODE="666", GROUP="plugdev"
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", MODE="666", GROUP="plugdev"
  # '';
  # networking.interfaces.tun0.mtu = 1200;
  # systemd.network.wait-online.anyInterface = true;
  # # systemd.network.wait-online.ignoredInterfaces = ["tun0"];
  # systemd.services.NetworkManager-wait-online.enable = false;

  environment.systemPackages = with pkgs; [
    sshpass
  ];
}
