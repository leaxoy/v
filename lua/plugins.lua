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
		use("henriquehbr/nvim-startup.lua")
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
				require("session-lens").setup({--[[your custom config--]]
					theme_conf = { border = true },
					previewer = true,
				})
				require("telescope").load_extension("session-lens")
			end,
		})

		-- Lang specifies
		use("solarnz/thrift.vim")
		use({
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("crates").setup()
			end,
		})

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
				"hrsh7th/cmp-cmdline",
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
				{ "golang/vscode-go", opt = true, ft = "go" },
				{ "cstrap/python-snippets", opt = true, ft = "python" },
			},
		})

		-- Debug
		use("mfussenegger/nvim-dap")
		use("Pocco81/DAPInstall.nvim")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } })
		use({
			"nvim-telescope/telescope-dap.nvim",
			requires = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
			config = function()
				require("telescope").load_extension("dap")
			end,
		})
		use({
			"rcarriga/vim-ultest",
			requires = { "vim-test/vim-test", "roxma/nvim-yarp", "roxma/vim-hug-neovim-rpc" },
			config = function() end,
			run = ":UpdateRemotePlugins",
		})

		-- UI Component
		use("projekt0n/github-nvim-theme")
		use("sainnhe/gruvbox-material")
		use("Mofiqul/vscode.nvim")
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/nvim-treesitter-textobjects")
		use("nvim-treesitter/nvim-treesitter-refactor")
		use("romgrk/nvim-treesitter-context")
		use("p00f/nvim-ts-rainbow")
		use("chentau/marks.nvim")
		use("lukas-reineke/indent-blankline.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use("simrat39/symbols-outline.nvim")
		use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
		use({ "kevinhwang91/nvim-bqf" })
		use({
			"rcarriga/nvim-notify",
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("telescope").load_extension("notify")
			end,
		})
		use({ "skywind3000/asynctasks.vim", requires = { "skywind3000/asyncrun.vim" } })

		-- VCS
		use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use({ "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } })

		-- Code edit
		use("numToStr/Comment.nvim")
		use("windwp/nvim-autopairs")
		use("famiu/bufdelete.nvim")
		use({
			"phaazon/hop.nvim",
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
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
		use("Pocco81/AutoSave.nvim")
		use("sbdchd/neoformat")
		use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("telescope").load_extension("todo-comments")
			end,
		})
		use({
			"edolphin-ydf/goimpl.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("telescope").load_extension("goimpl")
			end,
		})
		use("RRethy/vim-illuminate")

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
			"nvim-telescope/telescope-hop.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("telescope").load_extension("hop")
			end,
		})
		use({
			"nvim-telescope/telescope-project.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("telescope").load_extension("project")
			end,
		})
		use({
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup()
			end,
		})
		use({
			"sudormrfbin/cheatsheet.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
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
					layout = {
						height = { min = 6, max = 25 },
					},
				})
			end,
		})
		use({ "michaelb/sniprun", run = "bash ./install.sh" })

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = { git = { clone_timeout = 300 }, max_jobs = 25 },
})
