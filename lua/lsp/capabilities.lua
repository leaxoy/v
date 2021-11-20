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
	if client.resolved_capabilities.code_lens then
		vim.cmd([[highlight! link LspCodeLens WarningMsg]])
		vim.cmd([[highlight! link LspCodeLensText WarningMsg]])
		vim.cmd([[highlight! link LspCodeLensTextSign LspCodeLensText]])
		vim.cmd([[highlight! link LspCodeLensTextSeparator Boolean]])

		vim.api.nvim_command([[augroup CodeLenses]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.api.nvim_command([[augroup END]])
	end
end

M.highlight = function(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_command([[hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow]])
		vim.api.nvim_command([[hi LspReferenceText cterm=bold ctermbg=red guibg=DarkGreen]])
		vim.api.nvim_command([[hi LspReferenceWrite cterm=bold ctermbg=red guibg=DarkRed]])
		vim.api.nvim_command([[augroup Highlight]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
		vim.api.nvim_command([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
		vim.api.nvim_command([[augroup END]])
	end
end

M.format = function(client)
	-- try format with lsp, otherwise use Neoformat
	vim.api.nvim_command([[augroup Format]])
	vim.api.nvim_command([[autocmd! * <buffer>]])
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
	else
		vim.api.nvim_command([[autocmd BufWritePre <buffer> undojoin | Neoformat]])
	end
	vim.api.nvim_command([[augroup END]])
end

return M
