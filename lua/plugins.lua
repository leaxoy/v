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

-- Only required if you have packer configured as `opt`
-- vim.cmd([[packadd packer.nvim]])

local use = require("packer").use
return require("packer").startup({
  function()
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- startup
    use({ "lewis6991/impatient.nvim" })
    -- UI
    use("stevearc/dressing.nvim")
    use("sainnhe/gruvbox-material") -- theme
    use("Mofiqul/vscode.nvim") -- theme
    use("navarasu/onedark.nvim") -- theme
    use("kyazdani42/nvim-web-devicons") -- for file icons
    use("kyazdani42/nvim-tree.lua") -- file explorer
    use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- syntax highlighting
    use("p00f/nvim-ts-rainbow") -- colored brackets
    use("lukas-reineke/indent-blankline.nvim")
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

    -- Lsp config
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp", -- cmp from lsp
        { "zbirenbaum/copilot-cmp",
          requires = { "zbirenbaum/copilot.lua", "github/copilot.vim" },
          config = function() require("copilot").setup() end
        },
        "hrsh7th/cmp-buffer", -- cmp from buffer
        "hrsh7th/cmp-vsnip", -- cmp from snippet
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        -- "hrsh7th/cmp-nvim-lsp-signature-help",
        "onsails/lspkind-nvim", -- cmp menu text
        "lukas-reineke/cmp-under-comparator",
      },
    })
    use("b0o/SchemaStore.nvim")
    -- use("ray-x/lsp_signature.nvim")
    use("folke/lua-dev.nvim")
    use("simrat39/symbols-outline.nvim")

    -- Snippet config
    use({
      "hrsh7th/vim-vsnip",
      requires = {
        { "golang/vscode-go", opt = true, ft = "go" },
        { "cstrap/python-snippets", opt = true, ft = "python" },
        { "rafamadriz/friendly-snippets" },
      },
    })

    -- Debug
    use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } })
    use({ "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" })

    -- VCS
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

    -- Code edit
    -- use({ "karb94/neoscroll.nvim", config = function() require("neoscroll").setup() end })
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("famiu/bufdelete.nvim")
    use("mg979/vim-visual-multi")
    use({ "lewis6991/spellsitter.nvim", config = function() require("spellsitter").setup() end })
    use({ "ellisonleao/glow.nvim" }) -- markdown render
    use({ "kevinhwang91/nvim-hlslens" }) -- searching
    use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function() require("telescope").load_extension("todo-comments") end,
    })

    -- Editor tools
    use("akinsho/toggleterm.nvim")
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        -- Telescope Plugins
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-raw.nvim",
        "nvim-telescope/telescope-project.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-packer.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "aloussase/telescope-gradle.nvim",
        "edolphin-ydf/goimpl.nvim",
        "sudormrfbin/cheatsheet.nvim",
      },
    })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({
          window = { border = "double" },
          key_labels = { ["<space>"] = "SPC", ["<leader>"] = "SPC", ["<tab>"] = "TAB" },
          popup_mappings = { scroll_up = "<c-k>", scroll_down = "<c-j>", },
          layout = { height = { min = 3, max = 8 }, align = "center" },
          plugins = { spelling = { enabled = true } },
        })
      end,
    })

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
