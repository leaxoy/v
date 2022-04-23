local M = {}

M.on_attach = function(client, bufnr)
    require("lsp_signature").on_attach()
    require("illuminate").on_attach(client)

    require("lsp/commands").auto_command()
    require("lsp/keybinding").setup(bufnr)
    require("lsp/handler").setup()
    require("lsp/capabilities").codelens(client)
    require("lsp/capabilities").highlight(client)
    require("lsp/capabilities").format(client)
end

M.lsp_settings = {
    ["gopls"] = {
        gopls = {
            -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            -- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
            -- not supported
            analyses = {
                unusedparams = true,
                unreachable = true,
                unusedwrite = true,
                fieldalignment = true,
                nilness = true,
                shadow = true,
            },
            codelenses = {
                generate = true, -- show the `go generate` lens.
                gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                test = true,
                tidy = true,
                upgrade_dependency = true,
            },
            experimentalWorkspaceModule = true,
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            matcher = "Fuzzy",
            diagnosticsDelay = "500ms",
            experimentalWatchedFileDelay = "100ms",
            symbolMatcher = "fuzzy",
            ["local"] = "",
            gofumpt = true, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
            buildFlags = { "-tags", "integration" },
            -- buildFlags = {"-tags", "functional"}
        },
    },
    ["rust_analyzer"] = {
        rust_analyzer = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
        },
    },
}

M.lsp_init_options = {
    ["jdtls"] = {
        extendedClientCapabilities = {
            progressReportProvider = true,
            classFileContentsSupport = true,
            generateToStringPromptSupport = true,
            hashCodeEqualsPromptSupport = true,
            advancedExtractRefactoringSupport = true,
            advancedOrganizeImportsSupport = true,
            generateConstructorsPromptSupport = true,
            generateDelegateMethodsPromptSupport = true,
            moveRefactoringSupport = true,
            inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
        },
    },
}

M.setup = function()
    require("lsp/completion").setup()
    -- local lsp = require("lspconfig")
    -- lsp["sumneko_lua"].setup(require("lua-dev").setup())

    local opts = {
        on_attach = M.on_attach,
        capabilities = require("lsp/capabilities").update_capabilities(),
        flags = { debounce_text_changes = 150 },
    }
    local lsp_manager = require("nvim-lsp-installer")
    lsp_manager.on_server_ready(function(server)
        opts.settings = vim.tbl_deep_extend("keep", opts.settings or {}, M.lsp_settings[server.name] or {})
        -- opts.init_options = vim.tbl_deep_extend("keep", opts.init_options or {}, M.lsp_init_options[server.name] or {})
        opts.commands = vim.tbl_deep_extend("keep", opts.commands or {}, require("lsp/commands")[server.name] or {})
        if server.name == "sumneko_lua" then
            local luadev = require('lua-dev').setup()
            server:setup(luadev)
        else
            server:setup(opts)
        end
        vim.cmd([[ do User LspAttachBuffers ]])
    end)
end

return M
