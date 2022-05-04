local M = {}

M.on_attach = function(client, bufnr)
  require("lsp_signature").on_attach()
  require("illuminate").on_attach(client)

  require("lsp/keybinding").setup(bufnr)
  require("lsp/handler").setup()
  require("lsp/capabilities").codelens(client)
  require("lsp/capabilities").highlight(client)
  require("lsp/capabilities").format(client)
  require("lsp/capabilities").diagnostic(bufnr)
end

M.lsp_settings = {
  ["gopls"] = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      -- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
      -- not supported
      allExperiments = true,
      deepCompletion = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
        unusedwrite = true,
        fieldalignment = true,
        nilness = true,
        shadow = true,
      },
      annotations = {
        ["nil"] = true, escape = true, inline = true, bounds = true,
      },
      codelenses = {
        enable = true,
        enableByDefault = true,
        generate = true, -- show the `go generate` lens.
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        upgrade_dependency = true,
      },
      templateExtensions = { ".tmpl", ".html", ".gohtml", ".tmpl.html" },
      experimentalWorkspaceModule = true,
      hoverKind = "SynopsisDocumentation",
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
  ["jsonls"] = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  ["rust_analyzer"] = {
    rust_analyzer = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
  ["sumneko_lua"] = {
    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
        }
      },
    },
  }
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

  local lsp_manager = require("nvim-lsp-installer")
  lsp_manager.setup({
    ensure_installed = vim.g.lsp_servers,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  })

  local lspconfig = require("lspconfig");
  for _, server_name in pairs(vim.g.lsp_servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = require("lsp/capabilities").update_capabilities(),
      flags = { debounce_text_changes = 150 },
    }
    opts.settings = vim.tbl_deep_extend("keep", opts.settings or {}, M.lsp_settings[server_name] or {})
    opts.commands = vim.tbl_deep_extend("keep", opts.commands or {}, require("lsp/commands")[server_name] or {})
    -- opts.init_options = vim.tbl_deep_extend("keep", opts.init_options or {}, M.lsp_init_options[server.name] or {})
    if server_name == "sumneko_lua" then
      local luadev = require("lua-dev").setup({ lspconfig = opts })
      lspconfig[server_name].setup(luadev)
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
