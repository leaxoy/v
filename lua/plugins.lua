-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Lsp config
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'ray-x/lsp_signature.nvim'

    -- Code highlight
    use {
    	'nvim-treesitter/nvim-treesitter', 
	    run = ':TSUpdate'
    }
    use 'projekt0n/github-nvim-theme'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use 'simrat39/symbols-outline.nvim'

    -- File Explorer
    use 'kyazdani42/nvim-web-devicons' -- for file icons
    use 'kyazdani42/nvim-tree.lua'
    use 'akinsho/toggleterm.nvim'
    use 'windwp/nvim-autopairs'

    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'sbdchd/neoformat'
    use 'folke/which-key.nvim'
    use "b0o/mapx.nvim"
end)

