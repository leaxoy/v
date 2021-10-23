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
vim.cmd([[packadd packer.nvim]])

local use = require("packer").use
return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Lsp config
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp", -- cmp from lsp
			"hrsh7th/cmp-nvim-lua", -- cmp from lua
			"hrsh7th/cmp-buffer", -- cmp from buffer
			"hrsh7th/cmp-vsnip", -- cmp from snippet
			"onsails/lspkind-nvim",
		},
	})
	use("ray-x/lsp_signature.nvim")
	use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
	use({
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup()
		end,
	})
	use("folke/lua-dev.nvim")

	-- Snippet config
	use({
		"hrsh7th/vim-vsnip",
		requires = {
			"golang/vscode-go",
			"cstrap/python-snippets",
		},
	})

	-- Debug
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- UI Component
	use("projekt0n/github-nvim-theme")
	use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("p00f/nvim-ts-rainbow")
	use("romgrk/nvim-treesitter-context")
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("simrat39/symbols-outline.nvim")
	use("liuchengxu/vista.vim")
	use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
	use({
		"ray-x/navigator.lua",
		requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
	})
	use({
		"rcarriga/nvim-notify",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("notify")
		end,
	})
	use({ "skywind3000/asynctasks.vim", requires = { "skywind3000/asyncrun.vim" } })

	-- Code edit
	use("terrortylor/nvim-comment")
	use("windwp/nvim-autopairs")
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("sbdchd/neoformat")
	use({
		"edolphin-ydf/goimpl.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	})
	use("jubnzv/virtual-types.nvim")
	use("RRethy/vim-illuminate")
	use("rmagatti/auto-session")
	use({
		"rmagatti/session-lens",
		requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("session-lens")
			require("session-lens").setup({})
		end,
	})

	-- File Explorer
	use("kyazdani42/nvim-web-devicons") -- for file icons
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/toggleterm.nvim")
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" } })
	use({
		"nvim-telescope/telescope-packer.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("packer")
		end,
	})
	use({
		"nvim-telescope/telescope-project.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("project")
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("fzf")
		end,
		run = "make",
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	})
	use({
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				window = {
					border = "double",
				},
				key_labels = {
					["<space>"] = "SPC",
					["<tab>"] = "TAB",
				},
				layout = {
					height = { min = 6, max = 25 },
				},
			})
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
