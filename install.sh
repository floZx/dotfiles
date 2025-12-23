#!/bin/bash

# Installation des dotfiles
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installation des dotfiles depuis $DOTFILES_DIR"

# Nvim
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
echo "✓ nvim"

# Tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf
echo "✓ tmux"

echo ""
echo "Installation terminée !"
echo "Relance tmux et nvim pour appliquer les configs."
