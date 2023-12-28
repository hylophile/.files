function nxr --wraps='sudo nixos-rebuild switch --flake ~/.config/nixos/' --description 'alias nxr sudo nixos-rebuild switch --flake ~/.config/nixos/'
    sudo nixos-rebuild switch --flake ~/.config/nixos/ $argv
end
