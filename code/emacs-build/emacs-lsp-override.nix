# ~/code/emacs-lsp-build/emacs-lsp-override.nix

with (import <nixpkgs> { });

(emacs.override { nativeComp = true; }).overrideAttrs (old: {
  pname = "emacs";
  version = "head";
  src = fetchFromGitHub {
    owner = "emacs-lsp";
    repo = "emacs";
    rev = "299a8771567c9da0d7eb3ea8f69aefcc258ed93a";
    sha256 = "11hnm3rpa4gs7hkkskpjn945mqz2cgngacqc4wby9f1qjhs1j43z";
  };
  patches = [ ];
  configureFlags = old.configureFlags ++ [ "--with-json" ];
  preConfigure = "./autogen.sh";
  buildInputs = old.buildInputs ++ [ autoconf texinfo ];
})

# build:
# nix-build emacs-lsp-override.nix

# have ~/.nix-profile/bin in PATH

# install:
# nix-env -f emacs-lsp-override.nix -i '.*'
# doom sync

# in config:
# (setq lsp-idle-delay 0.01)
