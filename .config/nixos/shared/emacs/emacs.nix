{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    emacsPackages.vterm
    emacs-lsp-booster
    emacs29-pgtk
    # (pkgs.emacs-pgtk.overrideAttrs {
    #   patches = [
    #     ./support-image-transparent.patch
    #     ./vertical-border-respect-alpha-background.patch
    #     ./fringe-respect-alpha-background.patch
    #     ./add-rgba-support-for-faces-to-pgtk.patch
    #   ];
    # })
  ];
}
