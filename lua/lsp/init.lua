local M = {}

M.lsp_capabitities = function(cfg)
  cfg = cfg or {}

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local if_nil = function(val, default)
    if val == nil then
      return default
    end
    return val
  end

  local completionItem = capabilities.textDocument.completion.completionItem

  completionItem.snippetSupport = if_nil(cfg.snippetSupport, true)
  completionItem.preselectSupport = if_nil(cfg.preselectSupport, true)
  completionItem.insertReplaceSupport = if_nil(cfg.insertReplaceSupport, true)
  completionItem.labelDetailsSupport = if_nil(cfg.labelDetailsSupport, true)
  completionItem.deprecatedSupport = if_nil(cfg.deprecatedSupport, true)
  completionItem.commitCharactersSupport = if_nil(cfg.commitCharactersSupport, true)
  completionItem.tagSupport = if_nil(cfg.tagSupport, { valueSet = { 1 } })
  completionItem.resolveSupport = if_nil(cfg.resolveSupport, {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  })
  return capabilities
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
        unusedwrite = true,
        fieldalignment = true,
        nilness = true,
        shadow = true,
        useany = true,
      },
      annotations = { ["nil"] = true, escape = true, inline = true, bounds = true },
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
      semanticTokens = true,
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
      cargo = { allFeatures = true, features = { "all" }, },
      checkOnSave = { command = "clippy" },
    },
  },
  ["sumneko_lua"] = {
    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        -- see: https://github.com/CppCXY/EmmyLuaCodeStyle
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
        },
      },
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

M.setup = function(opt)
  opt = vim.tbl_deep_extend("keep", opt or {}, {})

  require("lsp/completion").setup()

  local lsp_manager = require("nvim-lsp-installer")
  lsp_manager.setup({
    ensure_installed = opt.lsp_servers,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗",
      },
    },
  })

  local lspconfig = require("lspconfig")
  for _, server_name in pairs(opt.lsp_servers) do
    local opts = {
      capabilities = M.lsp_capabitities(),
      flags = { debounce_text_changes = 150 },
      handlers = require("lsp.handler"),
    }
    opts.settings = vim.tbl_deep_extend(
      "keep",
      opts.settings or vim.empty_dict(),
      M.lsp_settings[server_name] or vim.empty_dict()
    )
    opts.commands = vim.tbl_deep_extend(
      "keep",
      opts.commands or vim.empty_dict(),
      require("lsp.commands")[server_name] or vim.empty_dict()
    )
    opts.init_options = vim.tbl_deep_extend(
      "keep",
      opts.init_options or vim.empty_dict(),
      M.lsp_init_options[server_name] or vim.empty_dict()
    )
    if server_name == "sumneko_lua" then
      local luadev = require("lua-dev").setup({ lspconfig = opts })
      lspconfig[server_name].setup(luadev)
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
