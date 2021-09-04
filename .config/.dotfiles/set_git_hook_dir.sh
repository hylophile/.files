#!/bin/sh

alias cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
cfg config core.hooksPath "$HOME/.config/.dotfiles/githooks"
