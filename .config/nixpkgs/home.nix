{ config, pkgs, ... }:

with (import <nixpkgs> { });

let emacsLSP = (import "/home/nsa/.config/nixpkgs/emacs-lsp.nix");
in {
  home.packages = [ emacsLSP shellcheck nixfmt pandoc babelfish ];
  # nix-shell -p babelfish
  # cat .nix-profile/etc/profile.d/hm-session-vars.sh| babelfish >> ~/.config/fish/hm-session-vars.fish

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nsa";
  home.homeDirectory = "/home/nsa";

  targets.genericLinux.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # dconf.settings = { "org/gnome/desktop/interface" = { cursor-size = 128; }; };

  home.pointerCursor = {
    name = "Adwaita";
    package = gnome.adwaita-icon-theme;
    size = 128;
    gtk.enable = true;
    x11.enable = true;
  };

  # gtk = {
  #   enable = true;
  #   cursorTheme.name = "Adwaita";
  #   cursorTheme.size = 48;
  # };

  xresources.properties = {
    "Xft.dpi" = 192;
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    # "Xcursor.size" = 48;
    # ! These might also be useful depending on your monitor and personal preference:
    # !Xft.autohint: 0
    # !Xft.lcdfilter:  lcddefault
    # !Xft.rgba: rgb
  };

  # programs.dconf.enable = true;
}
