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
- debugpy pour le debugger Python (`pip install debugpy`)

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
| `Space s` | Symbols du fichier (classes/fonctions) - matching exact |

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
| `Space y p` | Copier chemin:ligne dans le presse-papier |
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
| `Ctrl+w gF` | Ouvrir fichier:ligne sous curseur en split vertical |
| `Ctrl+o` | Retour en arrière (jumplist) |
| `Ctrl+i` | Avancer (jumplist) |

### Notes (~/notes)

| Raccourci | Action |
|-----------|--------|
| `Space n n` | Nouvelle note |
| `Space n f` | Chercher une note (fuzzy) |
| `Space n s` | Chercher dans le contenu des notes |
| `Space n t` | Note du jour (daily note) |
| `Space n b` | Parcourir ~/notes |

**Dans les fichiers markdown :**
- `[[` pour créer un lien vers une autre note (autocomplétion)
- `gf` sur un lien `[[note]]` pour l'ouvrir
- `Ctrl+o` pour revenir à la note précédente

### LSP (erreurs, autocomplétion)

| Raccourci | Action |
|-----------|--------|
| `gd` | Go to definition |
| `gr` | Références |
| `K` | Documentation hover |
| `Space c a` | Code actions |
| `Space r n` | Rename |
| `[d` / `]d` | Erreur précédente/suivante |
| `Space D` | Détails de l'erreur |

`:Mason` pour gérer les serveurs LSP installés.

### Debugger (Python/Django)

| Raccourci | Action |
|-----------|--------|
| `Space d b` | Toggle breakpoint |
| `Space d c` | Continuer / Lancer debug |
| `Space d o` | Step over |
| `Space d i` | Step into |
| `Space d O` | Step out |
| `Space d u` | Toggle UI debug |
| `Space d x` | Arrêter debug |
| `Space d r` | Ouvrir REPL |
| `Space d l` | Relancer dernier debug |

Pour Django : `Space d c` → choisir "Django"

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

### Copy mode (historique scrollback)

| Raccourci | Action |
|-----------|--------|
| `Ctrl+a v` | Entrer en copy mode |
| `h/j/k/l` | Naviguer |
| `/` ou `?` | Rechercher (bas/haut) |
| `n/N` | Résultat suivant/précédent |
| `v` | Commencer sélection |
| `y` | Copier et quitter |
| `q` | Quitter sans copier |

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
- **obsidian.nvim** - Gestion des notes markdown (liens `[[`, recherche)
- **markview.nvim** - Rendu markdown coloré (headings, tableaux)
- **nvim-treesitter-context** - Affiche fonction/classe courante en haut
- **nvim-cmp** - Autocomplétion (liens obsidian, paths, buffer)
- **nvim-dap** + **nvim-dap-ui** - Debugger Python/Django
- **nvim-lspconfig** + **mason.nvim** - LSP (erreurs, autocomplétion, go-to-definition)
- **which-key.nvim** - Affiche les raccourcis disponibles (tape Space et attends)
- **nvim-autopairs** - Ferme auto les parenthèses, crochets, guillemets
- **Comment.nvim** - Commenter avec `gcc` (ligne) ou `gc` (sélection)
- **nvim-surround** - Entourer une sélection avec `S"`, `S(`, etc.
- **lualine.nvim** - Barre de statut (mode, branche git, fichier, position)
- **marks.nvim** - Marks vim améliorés (affichés dans la marge)

## Marks (bookmarks de positions)

| Raccourci | Action |
|-----------|--------|
| `ma` | Créer mark 'a' à cette ligne |
| `'a` | Aller au mark 'a' |
| `dm<mark>` | Supprimer un mark |
| `m]` | Aller au mark suivant |
| `m[` | Aller au mark précédent |
| `m:` | Prévisualiser les marks |

- Marks minuscules (a-z) : locaux au fichier
- Marks majuscules (A-Z) : globaux (entre fichiers, persistants)

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
