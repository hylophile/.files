function remove-packages
    sudo pacman -R (pacgraph -c | rg -v "^warning" | head -n 100 | fzf -m | cut -d' ' -f 3)
    sudo pacman -Qtdq | sudo pacman -Rns -
    sudo pacman -Qqd | sudo pacman -Rsu -
end
