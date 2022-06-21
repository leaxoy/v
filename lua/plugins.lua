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
    use("stevearc/dressing.nvim") -- ui component
    use("sainnhe/gruvbox-material") -- theme
    use("Mofiqul/vscode.nvim") -- theme
    use("navarasu/onedark.nvim") -- theme
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }) -- file explorer
    -- use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- bufferline
    use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- statusline
    use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", config = function()
      vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = false, fg = "#6000ff" })
      vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#000000", fg = "#6000ff" })
      vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#000000", fg = "#357f2e" })
      vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#000000", fg = "#ffffff" })
      require("nvim-navic").setup {
        highlight = true,
        separator = " ▸ ",
        depth_limit = 0,
        depth_limit_indicator = "..",
      }
    end })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- syntax highlighting
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
    use({
      "weirongxu/plantuml-previewer.vim",
      requires = { "tyru/open-browser.vim", "aklt/plantuml-syntax" },
      opt = true, ft = "plantuml",
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
        "onsails/lspkind-nvim", -- cmp menu text
        "lukas-reineke/cmp-under-comparator",
      },
    })
    use("b0o/SchemaStore.nvim")
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
    -- use({ "karb94/neoscroll.nvim", config = function() require("neoscroll").setup() end })
    use({ "hrsh7th/nvim-pasta", config = function()
      require("pasta").setup({
        converters = {
          require("pasta.converters").indentation,
        },
        paste_mode = true,
        next_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
        prev_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
      })
    end })
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("famiu/bufdelete.nvim")
    use({ "sbdchd/neoformat" })
    use {
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
      config = function() require("ufo").setup() end
    }
    use({ "lewis6991/spellsitter.nvim", config = function() require("spellsitter").setup() end })
    use({ "ellisonleao/glow.nvim" }) -- markdown render
    use({ "kevinhwang91/nvim-hlslens" }) -- searching
    use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
    use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })

    -- Editor tools
    use("akinsho/toggleterm.nvim")
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        -- Telescope Plugins
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
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
