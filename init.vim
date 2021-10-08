call plug#begin()
" Lsp config
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" Code highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'projekt0n/github-nvim-theme'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" File Explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'akinsho/toggleterm.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'
Plug 'sbdchd/neoformat'

Plug 'windwp/nvim-autopairs'
call plug#end()

lua << EOF
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.completeopt = "menuone,noselect"
vim.o.autoindent = true
vim.o.showmatch = true

-- Setup nvim-cmp.
local cmp = require'cmp';

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-5),
    ['<C-f>'] = cmp.mapping.scroll_docs(5),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),
    ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
  },
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
  }
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-tree'.setup {
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

require'nvim-autopairs'.setup{}
require('github-theme').setup{}
require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"}
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

local lang_servers = {'clangd', 'gopls', 'pyright', 'rust_analyzer', 'tsserver'}
for _, lang_server in ipairs(lang_servers) do
    nvim_lsp[lang_server].setup{
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

require'bufferline'.setup{
    numbers = 'buffer_id',
    number_style = 'superscript',
    indicator_icon = '▎',
    offsets = {{
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
    }},
    show_buffer_icons = true,
    show_tab_indicators = true,
    separator_style = 'slant',
}
require('lualine').setup{
    options = { theme = 'ayu_dark' }
}
require("toggleterm").setup{
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    direction = 'float',
    shade_terminals = true,
}
require('neogit').setup{
    auto_refresh = true,
}

local map_opts = {noremap = true, silent = true};

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'b]', ':BufferLineCycleNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'b[', ':BufferLineCyclePrev<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'bb', ':buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'b1', '<CMD>BufferLineGoToBuffer 1<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b2', '<CMD>BufferLineGoToBuffer 2<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b3', '<CMD>BufferLineGoToBuffer 3<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b4', '<CMD>BufferLineGoToBuffer 4<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b5', '<CMD>BufferLineGoToBuffer 5<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b6', '<CMD>BufferLineGoToBuffer 6<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b7', '<CMD>BufferLineGoToBuffer 7<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b8', '<CMD>BufferLineGoToBuffer 8<CR>', map_opts)
vim.api.nvim_set_keymap('n', 'b9', '<CMD>BufferLineGoToBuffer 9<CR>', map_opts)

vim.api.nvim_set_keymap('n', '<C-h>', ":wincmd h<CR>", {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', ":wincmd j<CR>", {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', ":wincmd k<CR>", {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ":wincmd l<CR>", {noremap = false, silent = true})
EOF

