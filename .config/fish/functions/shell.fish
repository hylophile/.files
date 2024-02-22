function shell --wraps='nix shell nixpkgs#' --description 'alias shell nix shell nixpkgs#'
    NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs\#$argv --impure
    set -g IN_NIX_SHELL true
end
