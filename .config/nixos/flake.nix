{
  description = "hylo's NixOS";

  # This is the standard format for flake.nix.
  # `inputs` are the dependencies of the flake,
  # and `outputs` function will return all the build results of the flake.
  # Each item in `inputs` will be passed as a parameter to
  # the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    #    nixpkgs.url = "github:NixOS/nixpkgs/d65bceaee0fb1e64363f7871bc43dc1c6ecad99f";
    # home-manager, used for managing user configuration
    #    home-manager = {
    #      url = "github:nix-community/home-manager/release-23.11";
    #      # The `follows` keyword in inputs is used for inheritance.
    #      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
    #      # the `inputs.nixpkgs` of the current flake,
    #      # to avoid problems caused by different versions of nixpkgs.
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # emacs-lsp-booster = {
    #   url = "github:slotThe/emacs-lsp-booster-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # zig = {
    #   url = "github:mitchellh/zig-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # idris2 = {
    #   url = "github:idris-lang/idris2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  # `outputs` are all the build result of the flake.
  #
  # A flake can have many use cases and different types of outputs.
  #
  # parameters in function `outputs` are defined in `inputs` and
  # can be referenced by their names. However, `self` is an exception,
  # this special parameter points to the `outputs` itself(self-reference)
  #
  # The `@` syntax here is used to alias the attribute set of the
  # inputs's parameter, making it convenient to use inside the function.
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    my-overlays = {
      nixpkgs.overlays = [
        # inputs.emacs-lsp-booster.overlays.default
        # inputs.emacs-overlay.overlays.emacs
      ];
    };
  in {
    nixosConfigurations = {
      "rook" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs; # pass custom arguments into all sub module.
        modules = [./hosts/rook/configuration.nix my-overlays];
      };
      "knight" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs; # pass custom arguments into all sub module.
        modules = [./hosts/knight/configuration.nix my-overlays];
      };
    };
  };
}
