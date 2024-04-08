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
    ../../shared/sway.nix
    ../../shared/common-pc.nix
    ../../shared/emacs/emacs.nix
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

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };
  };
  users.extraGroups.docker.members = [uid];

  environment.systemPackages = with pkgs; [
    libreoffice-still # a
    python3
    nodejs_20
    tmux
    samba
    libsecret
    yarn
    openshift
    go
    gopls
  ];

  users.groups.uinput.members = ["${uid}"];
}
