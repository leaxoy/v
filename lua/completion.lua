local function bind_key(bufnr)
    -- local function m(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function o(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- Enable completion triggered by <c-x><c-o>
    o('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local m = require('utils/bind').bnm(bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    m('<space>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    m('<space>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    m('<space>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- m('<space>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- m('<space>gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    m('<space>gk', '<cmd>lua vim.lsp.buf.hover()<cr>')
    m('<space>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    m('<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>')
    m('<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>')
    m('<space>cl', '<cmd>lua vim.lsp.codelens.display()<cr>')
    -- m('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
    -- m('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
    -- m('<space>ww',
    --   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
    m('<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    -- m('<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    m('<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>')
    m('<space>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
    m('<space>ds', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
    m('<space>d[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
    m('<space>d]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
end

local function reg_handlers()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                                                 vim.lsp.handlers.hover,
                                                 {border = "single"})
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {update_in_insert = true})
end

local function setup()
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
        bind_key(bufnr)
        reg_handlers()

        -- auto format when save change
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_command [[augroup Format]]
            vim.api.nvim_command [[autocmd! * <buffer>]]
            vim.api
                .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
            vim.api.nvim_command [[augroup END]]
        end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local lang_servers = {
        'clangd', 'gopls', 'pyright', 'rust_analyzer', 'tsserver'
    }
    for _, lang_server in ipairs(lang_servers) do
        nvim_lsp[lang_server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {debounce_text_changes = 150}
        }
    end

    local cmp = require('cmp')

    cmp.setup({
        formatting = {
            format = require('lspkind').cmp_format({
                with_text = true,
                maxwidth = 50
            })
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
            end
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-5),
            ['<C-f>'] = cmp.mapping.scroll_docs(5),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<cr>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace
            }),
            ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})
        },
        sources = {
            {name = 'nvim_lsp'}, {name = 'vsnip'}, -- For vsnip user.
            {name = 'buffer'}
        }
    })
end

return {setup = setup}

