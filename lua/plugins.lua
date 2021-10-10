-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local use = require('packer').use
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Lsp config
    use 'neovim/nvim-lspconfig'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
            'onsails/lspkind-nvim', 'ray-x/lsp_signature.nvim',
            'kosayoda/nvim-lightbulb'
        }
    }
    use {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'}

    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}

    -- snippet config
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- Code highlight
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
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

    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'lewis6991/gitsigns.nvim'
    use 'sbdchd/neoformat'
    use 'folke/which-key.nvim'
    use "b0o/mapx.nvim"

    if packer_bootstrap then require('packer').sync() end
end)

