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
    use({ "linty-org/key-menu.nvim" })

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
    -- use("github/copilot.vim") -- now is not free
    use("hrsh7th/nvim-cmp")
    use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-vsnip", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp-document-symbol", requires = "hrsh7th/nvim-cmp" })
    use({ "onsails/lspkind-nvim", requires = "hrsh7th/nvim-cmp" })
    use({ "lukas-reineke/cmp-under-comparator", requires = "hrsh7th/nvim-cmp" })
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
