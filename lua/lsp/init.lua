local M = {}

local function type_hierarchy(method)
  vim.api.nvim_err_writeln("TypeHierarchy not supported in this version of nvim")
end

local function super_types() type_hierarchy("typeHierarchy/supertypes") end

local function sub_types() type_hierarchy("typeHierarch/subtypes") end

local function resolve_server_capabilities(client, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  local o = function(...) return vim.tbl_extend("force", opts, ...) end

  if client.server_capabilities.declarationProvider then
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, o({ desc = "Declaration" }))
  end
  if client.server_capabilities.definitionProvider then
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o({ desc = "Definition" }))
  end
  if client.server_capabilities.typeDefinitionProvider then
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, o({ desc = "Type Definition" }))
  end
  -- if client.server_capabilities.implementationProvider then
  --   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, o({ desc = "Implementation" }))
  -- end
  -- if client.server_capabilities.referencesProvider then
  --   vim.keymap.set("n", "gr", vim.lsp.buf.references, o({ desc = "References" }))
  -- end
  if client.server_capabilities.callHierarchyProvider then
    vim.keymap.set("n", "ghi", vim.lsp.buf.incoming_calls, o({ desc = "Incoming Calls" }))
    vim.keymap.set("n", "gho", vim.lsp.buf.outgoing_calls, o({ desc = "Outgoing Calls" }))
  end
  if client.server_capabilities.typeHierarchyProvider then
    vim.keymap.set("n", "ght", sub_types, o({ desc = "Sub Types" }))
    vim.keymap.set("n", "ghT", super_types, o({ desc = "Super Types" }))
  end
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_command([[hi! LspReferenceRead cterm=bold ctermbg=red guibg=Teal]])
    vim.api.nvim_command([[hi! LspReferenceText cterm=bold ctermbg=red guibg=Green]])
    vim.api.nvim_command([[hi! LspReferenceWrite cterm=bold ctermbg=red guibg=DarkRed]])
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = "lsp_document_highlight", })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
  -- if client.server_capabilities.documentLinkProvider then
  -- end
  if client.server_capabilities.hoverProvider then
    vim.keymap.set("n", "gk", vim.lsp.buf.hover, o({ desc = "Hover" }))
  end
  if client.server_capabilities.codeLensProvider then
    vim.cmd([[highlight! link LspCodeLens WarningMsg]])
    vim.cmd([[highlight! link LspCodeLensText WarningMsg]])
    vim.cmd([[highlight! link LspCodeLensTextSign LspCodeLensText]])
    vim.cmd([[highlight! link LspCodeLensTextSeparator Boolean]])

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
      pattern = "*", callback = vim.lsp.codelens.refresh
    })
    vim.keymap.set("n", "gad", vim.lsp.codelens.display, o({ desc = "Display CodeLens" }))
    vim.keymap.set("n", "gac", vim.lsp.codelens.run, o({ desc = "Run CodeLens" }))
    vim.keymap.set("n", "gaf", vim.lsp.codelens.run, o({ desc = "Refresh CodeLens" }))
  end
  -- if client.server_capabilities.foldingRangeProvider then
  -- end
  -- if client.server_capabilities.selectionRangeProvider then
  -- end
  if client.server_capabilities.documentSymbolProvider then
    -- vim.keymap.set("n", "go", vim.lsp.buf.document_symbol, o({ desc = "Document Symbol" }))
    vim.keymap.set("n", "go", "<cmd>SymbolsOutline<cr>", o({ desc = "Document Symbol" }))
  end
  -- if client.server_capabilities.semanticTokensProvider then
  -- end
  -- if client.server_capabilities.inlineValueProvider then
  -- end
  -- if client.server_capabilities.inlayHintProvider then
  -- end
  -- if client.server_capabilities.monikerProvider then
  -- end
  -- if client.server_capabilities.completionProvider then
  -- end
  -- if client.server_capabilities.diagnosticProvider then
  -- end
  if client.server_capabilities.signatureHelpProvider then
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, o({ desc = "Signature Help" }))
  end
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set("n", "gaa", vim.lsp.buf.code_action, o({ desc = "Code Action" }))
  end
  -- if client.server_capabilities.colorProvider then
  -- end
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_augroup("lsp_document_format", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = "lsp_document_format" })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = "lsp_document_format",
      buffer = buffer,
      command = "lua vim.lsp.buf.format()",
    })
  end
  -- if client.server_capabilities.documentRangeFormattingProvider then
  -- end
  -- if client.server_capabilities.documentOnTypeFormattingProvider then
  -- end
  if client.server_capabilities.renameProvider then
    vim.keymap.set("n", "gar", vim.lsp.buf.rename, o({ desc = "Rename" }))
  end
  -- if client.server_capabilities.linkedEditingRangeProvider then
  -- end

  --#region workspace start
  if client.server_capabilities.workspaceSymbolProvider then
    vim.keymap.set("n", "gO", vim.lsp.buf.workspace_symbol, o({ desc = "Workspace Symbol" }))
  end
  if client.server_capabilities.executeCommandProvider then
    local cmds = client.server_capabilities.executeCommandProvider.commands;
    for _, cmd in ipairs(cmds) do
      local name = cmd.command;
      local fn = function()
        local params = cmd.arguments and vim.lsp.util.make_position_params() or nil
        vim.lsp.buf.execute_command({ command = name, arguments = params })
      end
      vim.api.nvim_create_user_command(cmd:gsub(".", ""):gsub("_", ""), fn, {})
    end
    local execute_command = function()
      vim.ui.select(cmds, {
        prompt = "Execute Command:",
      }, function(choice)
        if not choice then return end
        vim.api.nvim_out_write("Execute command: " .. choice)
        vim.lsp.buf.execute_command({ command = choice, arguments = {} })
      end)
    end
    vim.keymap.set("n", "gec", execute_command, o({ desc = "Execute Command" }))
  end
  if client.server_capabilities.workspace and client.server_capabilities.workspace.workspaceFolders then
    vim.keymap.set("n", "gwa", vim.lsp.buf.add_workspace_folder, o({ desc = "Add Workspace" }))
    vim.keymap.set("n", "gwr", vim.lsp.buf.remove_workspace_folder, o({ desc = "Remove Workspace" }))
    vim.keymap.set("n", "gwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, o({ desc = "Add Workspace" }))
  end
end

local function resolve_client_capabilities(...)
  local cfg = ... or {}
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

M.activate = function(client, bufnr)
  resolve_server_capabilities(client, bufnr)
end

M.lsp_capabitities = function(cfg)
  return resolve_client_capabilities(cfg)
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
  opt = opt or {}
  if not opt.lsp_servers then
    opt.lsp_servers = vim.g.lsp_servers
  end

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
      "force",
      opts.settings or vim.empty_dict(),
      M.lsp_settings[server_name] or vim.empty_dict()
    )
    opts.commands = vim.tbl_deep_extend(
      "force",
      opts.commands or vim.empty_dict(),
      require("lsp.commands")[server_name] or vim.empty_dict(),
      require("lsp.commands")["default"] or vim.empty_dict()
    )
    opts.init_options = vim.tbl_deep_extend(
      "force",
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
