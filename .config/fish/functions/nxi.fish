function nxi
for p in $argv
nix profile install nixpkgs#$p
end
end
