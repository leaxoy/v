local M = {}

local function type_hierarchy(method)
  vim.api.nvim_err_writeln("TypeHierarchy not supported in this version of nvim")
end

local function super_types() type_hierarchy("typeHierarchy/supertypes") end

local function sub_types() type_hierarchy("typeHierarch/subtypes") end

local function resolve_lsp_capabilities(client, buffer)
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

M.autocmds = function()
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = {
      "go",
      "html",
      "javascriptreact",
      "javascript",
      "json",
      "kotlin",
      "lua",
      "rust",
      "typescriptreact",
      "typescript",
      "vue",
    },
    command = "setlocal tabstop=2 shiftwidth=2 expandtab",
    desc = "set tabstop and shiftwidth for specific filetypes",
  })
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buf = args.buf
      require("lsp_signature").on_attach({ bind = true, handler_opts = { border = "rounded" } }, buf)

      -- Enable completion triggered by <c-x><c-o>
      -- vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
      client.offset_encoding = "utf-16"
      resolve_lsp_capabilities(client, buf)
    end,
    desc = "setup lsp functions"
  })
end

return M
