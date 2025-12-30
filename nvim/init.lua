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

-- Fold basé sur treesitter (intelligent, par fonction/classe)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99  -- Ouvert par défaut

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

  -- Contexte sticky (affiche fonction/classe en haut quand on scrolle)
  { "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        max_lines = 3,
      })
    end,
  },

  -- LSP (erreurs, diagnostics, go-to-definition)
  { "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "lua_ls" },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Python
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Raccourcis LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)
        end,
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
  { "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Couleurs personnalisées pour les headings (style Catppuccin)
      vim.api.nvim_set_hl(0, "MarkviewHeading1", { bg = "#453a50", fg = "#f38ba8", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewHeading2", { bg = "#3a4550", fg = "#fab387", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewHeading3", { bg = "#3a5045", fg = "#a6e3a1", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewHeading4", { bg = "#3a4555", fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewHeading5", { bg = "#4a3a55", fg = "#cba6f7", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewHeading6", { bg = "#553a4a", fg = "#f5c2e7", bold = true })

      require("markview").setup({
        headings = {
          enable = true,
          heading_1 = { style = "label", hl = "MarkviewHeading1" },
          heading_2 = { style = "label", hl = "MarkviewHeading2" },
          heading_3 = { style = "label", hl = "MarkviewHeading3" },
          heading_4 = { style = "label", hl = "MarkviewHeading4" },
          heading_5 = { style = "label", hl = "MarkviewHeading5" },
          heading_6 = { style = "label", hl = "MarkviewHeading6" },
        },
      })
    end,
  },

  -- Notes (obsidian.nvim)
  { "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = function()
      require("obsidian").setup({
        workspaces = {
          { name = "notes", path = "~/notes" },
        },
        disable_frontmatter = true,
        ui = { enable = false },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
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

  -- Marks (bookmarks persistants avec positions)
  { "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = true,
        signs = true,
        mappings = {}
      })
    end,
  },

  -- Debugger (comme VSCode)
  { "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Python (utilise debugpy)
      require("dap-python").setup("python")

      -- Config Django
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django",
        program = "${workspaceFolder}/manage.py",
        args = { "runserver", "--noreload" },
        django = true,
        justMyCode = false,
      })
    end,
  },

  -- Autocomplétion
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "obsidian" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
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

-- Couleurs Neo-tree (dossiers bleus, fichiers blancs)
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#bbc2cf" })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#98be65" })
vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#ff6c6b" })

-- Keymaps Telescope (style VSCode)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<D-p>", builtin.find_files, { desc = "Rechercher fichiers" })
vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Rechercher fichiers" })
vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Rechercher dans fichiers" })
vim.keymap.set("n", "<leader>F", builtin.grep_string, { desc = "Rechercher mot sous curseur" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers ouverts" })
vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "Fichiers récents" })
vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Reprendre dernière recherche" })
vim.keymap.set("n", "<leader>s", function()
  builtin.lsp_document_symbols({ default_text = "'" })
end, { desc = "Symbols (classes/fonctions)" })

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
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gB", builtin.git_branches, { desc = "Changer de branche" })

-- Copier chemin:ligne dans le presse-papier
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local result = path .. ":" .. line
  vim.fn.setreg("+", result)
  print("Copié: " .. result)
end, { desc = "Copier chemin:ligne" })

vim.keymap.set("v", "<leader>yp", function()
  local path = vim.fn.expand("%")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then start_line, end_line = end_line, start_line end
  local result = path .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", result)
  print("Copié: " .. result)
end, { desc = "Copier chemin:lignes" })

-- Ouvrir fichier sous curseur en split vertical
vim.keymap.set("n", "<C-w>gF", ":vertical wincmd F<CR>", { desc = "Ouvrir fichier:ligne en split vertical" })

-- Debugger
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue/Start debug" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle debug UI" })
vim.keymap.set("n", "<leader>dx", function() require("dap").terminate() end, { desc = "Terminate debug" })

