{
  config,
  pkgs,
  eww,
  ...
}: let
  uid = "nsa";
in {
  imports = [
    ./hardware-configuration.nix
    ../../shared/sway.nix # a
    ../../shared/common-pc.nix
    ../../shared/uni-seclab.nix
    ./pki.nix
  ];

  boot.supportedFilesystems = ["ntfs"];
  boot.loader.systemd-boot.enable = true;

  # boot.kernelParams = [ "module_blacklist=amdgpu" ];
  # boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "knight"; # Define your hostname.

  networking.networkmanager = {
    enable = true;
    plugins = [pkgs.networkmanager-openconnect];
  };

  services.syncthing = {
    enable = true;
    user = uid;
    dataDir = "/home/${uid}/Documents";
    configDir = "/home/${uid}/.config/syncthing";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${uid}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.systemPackages = with pkgs; [
    libreoffice-still # a
    python3
    nodejs_20
    tmux
  ];

  users.groups.uinput.members = ["${uid}"];
}
