# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, eww, ... }:
let uid = "n";
in {
  imports = [
    ./hardware-configuration.nix
    ../../shared/sway.nix # a
    ../../shared/common-pc.nix
    ../../shared/uni-seclab.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];
  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    # extraEntries = {
    #   "z_Windows.conf" = ''
    #     title Windows
    #     efi /boot/EFI/BOOT/BOOTX64.EFI
    #   '';
    # };
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/01D4C223DAD568D0";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=${uid}" ];
  };
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/01D652F1F13E5B80";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=${uid}" ];
  };

  networking.hostName = "rook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  services.syncthing = {
    enable = true;
    user = uid;
    dataDir = "/home/${uid}/Documents";
    configDir = "/home/${uid}/.config/syncthing";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${uid}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.groups.uinput.members = [ "${uid}" ];

}
