{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.msmtp.enable = true;

  environment.systemPackages = with pkgs; [
    notmuch
    isync
    msmtp
    goimapnotify
  ];
}
