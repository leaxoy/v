-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local use = require("packer").use
return require("packer").startup({
  function()
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- startup
    use({ "lewis6991/impatient.nvim" })
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
              enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
              suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
              operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
              motions = true, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = true, -- default bindings on <c-w>
              nav = true, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true, -- bindings for prefixed with g
            },
          },
          -- add operators that will trigger motion and text object completion
          -- to enable all native operators, set the preset / operators plugin above
          operators = { gc = "Comments" },
          key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
          },
          popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
          },
          window = {
            border = "double", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0
          },
          layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "center", -- align columns left, center or right
          },
          ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
          hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
          -- triggers = {"<leader>"} -- or specify a list manually
          triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
          },
        }
      end
    }

    -- UI
    use("stevearc/dressing.nvim") -- ui component
    use("Mofiqul/vscode.nvim") -- theme
    use("sainnhe/gruvbox-material") -- theme
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }) -- file explorer
    use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- statusline
    use({
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
      config = function()
        require("nvim-navic").setup {
          highlight = true,
          separator = " ▸ ",
          depth_limit = 0,
          depth_limit_indicator = "..",
        }
      end
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- syntax highlighting
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "kevinhwang91/nvim-bqf" })
    use({ "rcarriga/nvim-notify", config = function() require("notify").setup({ background_colour = "#FFFFFF" }) end })
    use({ "romgrk/searchbox.nvim", requires = { { "MunifTanjim/nui.nvim" } } })

    -- Lang specifies
    use({ "solarnz/thrift.vim", opt = true, ft = "thrift" })
    use({ "luzhlon/xmake.vim", event = { "BufRead xmake.lua" } })
    use({
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function() require("crates").setup() end,
    })
    use({
      "weirongxu/plantuml-previewer.vim",
      requires = { "tyru/open-browser.vim", "aklt/plantuml-syntax" },
      opt = true, ft = "plantuml",
    })

    -- Lsp config
    use("williamboman/nvim-lsp-installer")
    use("neovim/nvim-lspconfig")
    use("github/copilot.vim") -- now is not free
    use("hrsh7th/nvim-cmp")
    use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-vsnip", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp-document-symbol", requires = "hrsh7th/nvim-cmp" })
    use({ "onsails/lspkind-nvim", requires = "hrsh7th/nvim-cmp" })
    use({ "lukas-reineke/cmp-under-comparator", requires = "hrsh7th/nvim-cmp" })
    use { "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } }
    use({ "simrat39/symbols-outline.nvim", requires = "neovim/nvim-lspconfig" })
    use("b0o/SchemaStore.nvim")
    use("folke/lua-dev.nvim")

    -- Snippet config
    use("hrsh7th/vim-vsnip")
    use({ "golang/vscode-go", opt = true, ft = "go", requires = "hrsh7th/vim-vsnip" })
    use({ "cstrap/python-snippets", opt = true, ft = "python", requires = "hrsh7th/vim-vsnip" })
    use({ "rafamadriz/friendly-snippets", requires = "hrsh7th/vim-vsnip" })

    -- Debug & Test
    use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } })
    use({
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-python",
        { "nvim-neotest/neotest-vim-test", requires = "vim-test/vim-test" }
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-python")({
              -- Extra arguments for nvim-dap configuration
              dap = { justMyCode = false },
              -- Command line arguments for runner
              -- Can also be a function to return dynamic values
              args = { "--log-level", "DEBUG" },
              -- Runner to use. Will use pytest if available by default.
              -- Can be a function to return dynamic value.
              runner = "pytest",

              -- Returns if a given file path is a test file.
              -- NB: This function is called a lot so don't perform any heavy tasks within it.
              is_test_file = function(file_path)
              end,
            }),
            require("neotest-go"),
            require("neotest-vim-test")({ ignore_file_types = { "python", "go" } }),
          },
          icons = { running = "ﭦ" },
          summary = {
            mappings = { jumpto = "<CR>", expand = "<TAB>" }
          },
        })
      end
    })

    -- VCS
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

    -- Code edit
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("famiu/bufdelete.nvim")
    use("sbdchd/neoformat")
    use("terryma/vim-multiple-cursors")
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })
    use({ "lewis6991/spellsitter.nvim", config = function() require("spellsitter").setup() end })
    use("ellisonleao/glow.nvim") -- markdown render
    use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
    use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })

    -- Editor tools
    use("akinsho/toggleterm.nvim")
    use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
    })
    -- Telescope Plugins
    use({ "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-live-grep-args.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-project.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-dap.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-packer.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-media-files.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "aloussase/telescope-gradle.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "edolphin-ydf/goimpl.nvim", requires = "nvim-telescope/telescope.nvim" })
    use({ "sudormrfbin/cheatsheet.nvim", requires = "nvim-telescope/telescope.nvim" })

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    git = { clone_timeout = 300 },
    max_jobs = 25,
    compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
  },
})
