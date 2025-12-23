# Dotfiles

Ma configuration Neovim + Tmux avec thème Doom One.

## Installation

```bash
git clone https://github.com/floZx/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Prérequis

- Neovim >= 0.9
- Tmux
- Une police Nerd Font (ex: `brew install --cask font-hack-nerd-font`)
- ripgrep pour Telescope (`brew install ripgrep`)

## Mise à jour

```bash
cd ~/dotfiles
git pull
```

Les symlinks pointent vers ce dépôt, donc les changements sont appliqués automatiquement.

## Contenu

- `nvim/init.lua` - Configuration Neovim avec lazy.nvim
- `tmux/.tmux.conf` - Configuration Tmux

## Plugins Neovim

- doom-one.vim (thème)
- nvim-treesitter (coloration syntaxique)
- telescope.nvim (fuzzy finder)
- neo-tree.nvim (explorateur fichiers)
- vim-tmux-navigator (navigation)
- vim-fugitive + diffview + gitsigns (git)
- obsidian.nvim (notes)
- render-markdown.nvim (markdown joli)
