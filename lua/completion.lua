local function setup()
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', '<space>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap('n', '<space>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        buf_set_keymap('n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap('n', '<space>gk', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        buf_set_keymap('n', '<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', opts)
        buf_set_keymap('n', '<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', opts)
        buf_set_keymap('n', '<space>cl', '<cmd>lua vim.lsp.codelens.get()<cr>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
        --  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
        buf_set_keymap('n', '<space>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
        buf_set_keymap('n', '<space>d[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
        buf_set_keymap('n', '<space>d]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = "single"
        }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "single"
        }
    )

    local lang_servers = {'clangd', 'gopls', 'pyright', 'rust_analyzer', 'tsserver'}
    for _, lang_server in ipairs(lang_servers) do
        nvim_lsp[lang_server].setup{
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end

    local cmp = require'cmp';

    cmp.setup({
        formatting = {
            format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-5),
            ['<C-f>'] = cmp.mapping.scroll_docs(5),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<cr>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),
            ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        },
        sources = {
            { name = 'nvim_lsp' },

            -- For vsnip user.
            { name = 'vsnip' },

            { name = 'buffer' },
        }
    })
end

return {setup = setup}

