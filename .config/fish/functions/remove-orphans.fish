function remove-orphans
sudo pacman -Qtdq | sudo pacman -Rns -
end
