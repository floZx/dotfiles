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

---

# Raccourcis Neovim & Tmux

## Neovim

### Recherche (Telescope)

| Raccourci | Action |
|-----------|--------|
| `Space p` | Rechercher fichiers (fuzzy, comme Cmd+P) |
| `Space f` | Rechercher dans le contenu (grep) |
| `Space F` | Rechercher le mot sous le curseur |
| `Space b` | Buffers ouverts |
| `Space r` | Fichiers récents |
| `Space Space` | Reprendre la dernière recherche |

**Dans les résultats Telescope :**
- `↑/↓` ou `Ctrl+n/p` pour naviguer
- `Enter` pour ouvrir
- `Ctrl+v` ouvrir en split vertical
- `Ctrl+x` ouvrir en split horizontal
- `Esc` pour fermer

### Arborescence (Neo-tree)

| Raccourci | Action |
|-----------|--------|
| `Space e` | Ouvrir/fermer l'explorateur |
| `Space o` | Focus sur l'explorateur |

**Dans l'arborescence :**
- `Enter` ouvrir fichier
- `a` créer fichier/dossier
- `d` supprimer
- `r` renommer
- `c` copier
- `m` déplacer
- `?` aide

### Git

| Raccourci | Action |
|-----------|--------|
| `Space g h` | Historique du fichier (vue graphique) |
| `Space g l` | Git log du fichier (texte) |
| `Space g b` | Git blame |
| `Space g B` | Changer de branche (fuzzy) |
| `Space g s` | Git status |
| `Space g d` | Diff des changements en cours |
| `Space g c` | Fermer la vue diff |

### Redimensionnement splits

| Raccourci | Action |
|-----------|--------|
| `Space w h` | Réduire largeur |
| `Space w l` | Agrandir largeur |
| `Space w j` | Réduire hauteur |
| `Space w k` | Agrandir hauteur |
| `Space w =` | Égaliser les splits |
| `Space w m` | Maximiser (fermer autres splits) |

### Navigation

| Raccourci | Action |
|-----------|--------|
| `Ctrl+h/j/k/l` | Naviguer entre splits nvim/tmux |

### Notes (~/notes)

| Raccourci | Action |
|-----------|--------|
| `Space n n` | Nouvelle note |
| `Space n f` | Chercher une note (fuzzy) |
| `Space n s` | Chercher dans le contenu des notes |
| `Space n t` | Note du jour (daily note) |
| `Space n b` | Parcourir ~/notes |

**Dans les fichiers markdown :**
- `[[` pour créer un lien vers une autre note
- `gf` sur un lien `[[note]]` pour l'ouvrir

---

## Tmux

### Général

| Raccourci | Action |
|-----------|--------|
| `Ctrl+a` ou `Ctrl+b` | Préfixe tmux |
| `Ctrl+a r` | Recharger la config |

### Panes

| Raccourci | Action |
|-----------|--------|
| `Ctrl+a \|` | Split vertical |
| `Ctrl+a -` | Split horizontal |
| `Ctrl+h/j/k/l` | Naviguer entre panes (fonctionne aussi dans nvim) |
| `Ctrl+a z` | Zoom/unzoom le pane (plein écran) |
| `Ctrl+a Space` | Cycle entre les layouts |

### Redimensionnement panes

| Raccourci | Action |
|-----------|--------|
| `Ctrl+a H` | Agrandir vers la gauche |
| `Ctrl+a J` | Agrandir vers le bas |
| `Ctrl+a K` | Agrandir vers le haut |
| `Ctrl+a L` | Agrandir vers la droite |
| `Ctrl+a =` | Égaliser horizontalement |
| `Ctrl+a +` | Égaliser verticalement |

---

## Thème

Doom One (cohérent avec iTerm2)

## Plugins Neovim installés

- **lazy.nvim** - Gestionnaire de plugins
- **doom-one.vim** - Thème
- **nvim-treesitter** - Coloration syntaxique avancée
- **telescope.nvim** - Fuzzy finder
- **neo-tree.nvim** - Explorateur de fichiers
- **vim-tmux-navigator** - Navigation entre nvim et tmux
- **vim-fugitive** - Commandes git
- **diffview.nvim** - Historique et diffs visuels
- **gitsigns.nvim** - Indicateurs git dans la marge
- **nvim-web-devicons** - Icônes
- **obsidian.nvim** - Gestion des notes markdown
- **render-markdown.nvim** - Rendu markdown joli (`:RenderMarkdown toggle` pour activer/désactiver)
- **which-key.nvim** - Affiche les raccourcis disponibles (tape Space et attends)
- **nvim-autopairs** - Ferme auto les parenthèses, crochets, guillemets
- **Comment.nvim** - Commenter avec `gcc` (ligne) ou `gc` (sélection)
- **nvim-surround** - Entourer une sélection avec `S"`, `S(`, etc.
- **lualine.nvim** - Barre de statut (mode, branche git, fichier, position)
- **harpoon** - Bookmarks persistants par projet

## Bookmarks (Harpoon)

| Raccourci | Action |
|-----------|--------|
| `Space h a` | Ajouter le fichier aux bookmarks |
| `Space h h` | Ouvrir la liste des bookmarks |
| `Space 1/2/3/4` | Aller au bookmark 1/2/3/4 |

Les bookmarks sont persistants par projet (sauvegardés automatiquement).

## Surround (entourer du texte)

**En mode visuel :**
- Sélectionne du texte
- `S"` → entoure de `"`
- `S(` → entoure de `()`
- `S{` → entoure de `{}`

**En mode normal :**
- `ysiw"` → entoure le mot de `"`
- `cs"'` → change `"` en `'`
- `ds"` → supprime les `"`
