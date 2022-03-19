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
return require("packer").startup({
	function()
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- startup
		use({ "lewis6991/impatient.nvim" })
		use({
			"rmagatti/auto-session",
			config = function()
				require("auto-session").setup({
					log_level = "info",
				})
			end,
		})
		use({
			"rmagatti/session-lens",
			requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
			config = function()
				require("session-lens").setup({
					theme_conf = { border = true },
					previewer = true,
				})
				require("telescope").load_extension("session-lens")
			end,
		})

		-- Lang specifies
		use("solarnz/thrift.vim")
		use({
			"saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("crates").setup()
			end,
		})
		use({
			"skanehira/preview-uml.vim",
			requires = { { "aklt/plantuml-syntax", ft = "plantuml", opt = true } },
			ft = "plantuml",
			opt = true,
		})

		-- Lsp config
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use({
			"hrsh7th/nvim-cmp",
			branch = "dev",
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- cmp from lsp
				{ "hrsh7th/cmp-copilot", requires = { "github/copilot.vim" } },
				"hrsh7th/cmp-nvim-lua", -- cmp from lua
				"hrsh7th/cmp-buffer", -- cmp from buffer
				"hrsh7th/cmp-vsnip", -- cmp from snippet
				"onsails/lspkind-nvim", -- cmp menu text
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"lukas-reineke/cmp-under-comparator",
				"f3fora/cmp-spell",
			},
		})
		use("ray-x/lsp_signature.nvim")
		use({
			"RishabhRD/lspactions",
			requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
		})
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
		use("folke/lua-dev.nvim")
		use({
			"ldelossa/litee.nvim",
			requires = {
				"ldelossa/litee-calltree.nvim",
				"ldelossa/litee-symboltree.nvim",
				"ldelossa/litee-filetree.nvim",
				"ldelossa/litee-bookmarks.nvim",
			},
			config = function()
				require("litee.lib").setup({
					tree = { icon_set = "nerd", indent_guides = true },
					panel = { orientation = "left", panel_size = 30 },
				})
				require("litee.calltree").setup({ icon_set = "nerd" })
				require("litee.symboltree").setup({ icon_set = "nerd" })
				require("litee.filetree").setup({ icon_set = "nerd" })
				require("litee.bookmarks").setup({ icon_set = "nerd" })
			end,
		})

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
		use("Pocco81/DAPInstall.nvim")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } })
		use({ "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" })

		-- UI Component
		use("projekt0n/github-nvim-theme")
		use("sainnhe/gruvbox-material")
		use("Mofiqul/vscode.nvim")
		use("bluz71/vim-moonfly-colors")
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("romgrk/nvim-treesitter-context")
		use("p00f/nvim-ts-rainbow")
		use("chentau/marks.nvim")
		use("lukas-reineke/indent-blankline.nvim")
		use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
		use({ "kevinhwang91/nvim-bqf" })

		-- VCS
		use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

		-- Code edit
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup()
			end,
		})
		use("numToStr/Comment.nvim")
		use("windwp/nvim-autopairs")
		use("famiu/bufdelete.nvim")
		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("spellsitter").setup()
			end,
		})
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		})
		use({
			"gbprod/substitute.nvim",
			config = function()
				require("substitute").setup()
			end,
		})
		use({ "ellisonleao/glow.nvim" }) -- markdown render
		use({ "kevinhwang91/nvim-hlslens" }) -- searching
		use({
			"jghauser/mkdir.nvim",
			config = function()
				require("mkdir")
			end,
		})
		use("sbdchd/neoformat")
		use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("telescope").load_extension("todo-comments")
			end,
		})
		use("RRethy/vim-illuminate")

		-- File Explorer
		use("kyazdani42/nvim-web-devicons") -- for file icons
		use("kyazdani42/nvim-tree.lua")
		use("akinsho/toggleterm.nvim")
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-lua/popup.nvim",
				-- Telescope Plugins
				"nvim-telescope/telescope-file-browser.nvim",
				"nvim-telescope/telescope-project.nvim",
				"nvim-telescope/telescope-dap.nvim",
				"edolphin-ydf/goimpl.nvim",
				"sudormrfbin/cheatsheet.nvim",
				"LinArcX/telescope-command-palette.nvim",
			},
		})
		use({
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({ mode = "document_diagnostics", use_diagnostic_signs = true })
			end,
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
						["<leader>"] = "SPC",
						["<tab>"] = "TAB",
					},
					layout = { height = { min = 3, max = 5 } },
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
