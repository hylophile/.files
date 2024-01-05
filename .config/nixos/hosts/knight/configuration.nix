{ config, pkgs, eww, ... }:
let uid = "nsa";
in {
  imports = [
    ./hardware-configuration.nix
    ../../shared/sway.nix # a
    ../../shared/common-pc.nix
    ../../shared/uni-seclab.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "knight"; # Define your hostname.

  services.syncthing = {
    enable = true;
    user = uid;
    dataDir = "/home/${uid}/Documents";
    configDir = "/home/${uid}/.config/syncthing";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${uid}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    libreoffice-still
  ];

  users.groups.uinput.members = [ "${uid}" ];

}
