# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  wezterm,
  zig,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  # boot.supportedFilesystems = [ "ntfs" ];
  # # Bootloader.
  # boot.loader.systemd-boot.enable = true;

  # boot.initrd.kernelModules = [ "amdgpu" ];
  # # boot.loader.grub.enable = true;
  # # boot.loader.grub.device = "/dev/sda";
  # # boot.loader.grub.useOSProber = true;

  # networking.hostName = "rook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.extraHosts = ''
    167.235.153.26 minivee
    10.11.99.1 remarkable-usb
    192.168.0.123 remarkable-wifi
    192.168.0.159 seki
    192.168.0.52 beemo
  '';

  # for virtual input devices without root
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  users.extraGroups = {
    uinput = {}; # a
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };

    displayManager.gdm = {enable = true;};
    desktopManager.gnome = {enable = true;};
    # displayManager.sddm = {
    #   enable = true;
    #   wayland.enable = true;
    # };
    # desktopManager.plasma6.enable = true;
  };
  security.pam.services.gdm.enableGnomeKeyring = true;

  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    # drivers = [ pkgs.samsung-unified-linux-driver ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # services.tailscale.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  zramSwap.enable = true;

  users.defaultUserShell = pkgs.fish;

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # editors
    vim
    neovim
    neovide
    helix

    # terminal
    wezterm.packages."${pkgs.system}".default
    kitty

    # gui
    libsForQt5.dolphin
    libsForQt5.dolphin-plugins
    libsForQt5.kio-extras
    libsForQt5.breeze-icons
    firefox
    ungoogled-chromium
    mpv
    qbittorrent
    xournalpp
    zathura
    pavucontrol
    telegram-desktop
    wvkbd
    inkscape-with-extensions

    # shell
    wget
    zoxide
    bat
    ripgrep
    rclone
    imv
    gron
    fd
    fzf
    atool
    zip
    unzip
    entr
    watchexec
    btop
    lsd
    libsecret
    pinentry-gnome3
    rbw
    hyperfine

    # dev
    distrobox
    git

    # lang
    ## nix
    alejandra # nix formatter
    ## go
    go
    gopls
    ## js
    vscode-langservers-extracted
    nodePackages.prettier
    typescript
    nodePackages.typescript-language-server
    nodejs_20
    corepack_20
    # idris2.packages."${pkgs.system}".default
    ## python
    python312
    ruff
    ruff-lsp
    black
    nodePackages.pyright
    uv
    ## clojure
    babashka
    clojure-lsp
    ## shell
    shfmt
    shellcheck
    ## c
    clang
    clang-tools
    bear
    gcc
    ## lua
    lua-language-server
    stylua
    ## zig
    zig.packages."${pkgs.system}".master
    zls
    gdb
    llvmPackages_latest.llvm

    # files
    yazi
    ncdu
    dua

    # misc
    # nix-index # todo: figure me out
    wf-recorder # screen recording
    imagemagick
    gammastep
    udiskie
    darkman
    texliveFull
    # (pkgs.texlive.combine {
    #   inherit (pkgs.texlive)
    #     scheme-basic dvisvgm dvipng # for preview and export as html
    #     etoolbox mylatexformat xcolor preview wrapfig amsmath ulem hyperref
    #     unicode-math lualatex-math capt-of;
    #   #(setq org-latex-compiler "lualatex")
    #   #(setq org-preview-latex-default-process 'dvisvgm)
    # })

    # fish
    fishPlugins.done
  ];

  programs.fish.enable = true;
  programs.nix-index.enable = true;
  programs.direnv.enable = true;
  programs.command-not-found.enable = false;

  programs.steam = {
    enable = true;
  };
  programs.gnupg.agent.enable = true;
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   # style = "adwaita-dark";
  #   # style = {
  #   #   package = pkgs.arc-kde-theme;
  #   #   name = "Arc";
  #   # };
  # };

  # qt = {
  #   enable = true;
  #   platformTheme = "qt5ct";
  #   style = {
  #     package = pkgs.arc-kde-theme;
  #     name = "Arc";
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
