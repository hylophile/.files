function remove-packages
sudo pacman -R (pacgraph -c | rg -v "^warning" | head -n 100 | fzf -m | cut -d' ' -f 2)
end
