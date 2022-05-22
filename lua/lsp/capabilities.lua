local M = {}

M.update_capabilities = function(cfg)
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

M.codelens = function(client)
  if client.server_capabilities.codeLensProvider then
    vim.cmd([[highlight! link LspCodeLens WarningMsg]])
    vim.cmd([[highlight! link LspCodeLensText WarningMsg]])
    vim.cmd([[highlight! link LspCodeLensTextSign LspCodeLensText]])
    vim.cmd([[highlight! link LspCodeLensTextSeparator Boolean]])

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
      pattern = "*",
      command = "lua vim.lsp.codelens.refresh()"
    })
  end
end

M.highlight = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_command([[hi! LspReferenceRead cterm=bold ctermbg=red guibg=Teal]])
    vim.api.nvim_command([[hi! LspReferenceText cterm=bold ctermbg=red guibg=Green]])
    vim.api.nvim_command([[hi! LspReferenceWrite cterm=bold ctermbg=red guibg=DarkRed]])
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight", })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.format = function(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "lua vim.lsp.buf.format()" })
  end
end

return M
