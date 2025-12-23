-- Options de base
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- Intégration tmux
vim.opt.ttimeoutlen = 5

-- Recharger automatiquement les fichiers modifiés
vim.opt.autoread = true
vim.opt.hidden = true  -- Permet de changer de buffer sans sauvegarder

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- Leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Icônes
  { "nvim-tree/nvim-web-devicons" },

  -- Thème Doom One
  { "romgrk/doom-one.vim", priority = 1000 },

  -- Treesitter (coloration syntaxique avancée)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json", "bash", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Navigation tmux <-> nvim avec Ctrl+hjkl
  { "christoomey/vim-tmux-navigator" },

  -- Telescope (fuzzy finder comme Cmd+P dans VSCode)
  { "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top" },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Git: fugitive (commandes git)
  { "tpope/vim-fugitive" },

  -- Git: diffview (historique fichier, diffs visuels)
  { "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Markdown joli
  { "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({})
    end,
  },

  -- Notes (obsidian.nvim)
  { "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("obsidian").setup({
        workspaces = {
          { name = "notes", path = "~/notes" },
        },
        disable_frontmatter = true,
        ui = { enable = false },
      })
    end,
  },

  -- Arborescence fichiers
  { "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      })
    end,
  },

  -- Git: gitsigns (indicateurs dans la marge)
  { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false, -- activer avec :Gitsigns toggle_current_line_blame
      })
    end,
  },

  -- Which-key (affiche les raccourcis disponibles)
  { "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- Autopairs (ferme auto les parenthèses, etc.)
  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Comment (gcc pour commenter)
  { "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  },

  -- Surround (entourer une sélection)
  { "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Lualine (barre de statut avec branche git)
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
})

-- Appliquer le thème
vim.cmd.colorscheme("doom-one")

-- Keymaps Telescope (style VSCode)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<D-p>", builtin.find_files, { desc = "Rechercher fichiers" })
vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Rechercher fichiers" })
vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Rechercher dans fichiers" })
vim.keymap.set("n", "<leader>F", builtin.grep_string, { desc = "Rechercher mot sous curseur" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers ouverts" })
vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "Fichiers récents" })
vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Reprendre dernière recherche" })

-- Arborescence
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorateur fichiers" })
vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus explorateur" })

-- Notes (~/notes)
vim.keymap.set("n", "<leader>nn", ":ObsidianNew<CR>", { desc = "Nouvelle note" })
vim.keymap.set("n", "<leader>nf", ":ObsidianQuickSwitch<CR>", { desc = "Chercher note" })
vim.keymap.set("n", "<leader>ns", ":ObsidianSearch<CR>", { desc = "Chercher dans notes" })
vim.keymap.set("n", "<leader>nt", ":ObsidianToday<CR>", { desc = "Note du jour" })
vim.keymap.set("n", "<leader>nb", ":Neotree ~/notes<CR>", { desc = "Browser notes" })

-- Keymaps redimensionnement splits (Space + w puis direction)
vim.keymap.set("n", "<leader>wh", ":vertical resize -5<CR>", { desc = "Réduire largeur" })
vim.keymap.set("n", "<leader>wl", ":vertical resize +5<CR>", { desc = "Agrandir largeur" })
vim.keymap.set("n", "<leader>wj", ":resize -3<CR>", { desc = "Réduire hauteur" })
vim.keymap.set("n", "<leader>wk", ":resize +3<CR>", { desc = "Agrandir hauteur" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Égaliser les splits" })
vim.keymap.set("n", "<leader>wm", ":only<CR>", { desc = "Maximiser (fermer autres splits)" })

-- Keymaps Git
vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "Historique du fichier" })
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff working tree" })
vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Fermer diffview" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gl", ":Git log %<CR>", { desc = "Git log fichier" })
