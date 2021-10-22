local function bind_key(bufnr)
	local function o(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	-- Enable completion triggered by <c-x><c-o>
	o("omnifunc", "v:lua.vim.lsp.omnifunc")

	local m = require("utils/bind").bnm(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	m("<space>gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
	m("<space>gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
	m("<space>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
	m("<space>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>") -- use telescope `fi`
	m("<space>gr", "<cmd>lua vim.lsp.buf.references()<cr>") -- use telescope `fr`
	m("<space>gk", "<cmd>lua vim.lsp.buf.hover()<cr>")
	m("<space>gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	m("<space>gf", "<cmd>lua vim.lsp.buf.formatting()<cr>")
	m("<space>ci", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>")
	m("<space>co", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>")
	m("<space>cl", "<cmd>lua vim.lsp.codelens.display()<cr>")
	-- m('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	-- m('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	-- m('<space>ww',
	--   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	m("<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
	m("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>") -- use telescope `fa`
	m("<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>")
	m("<space>dd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>") -- auto show
	m("<space>d[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>")
	m("<space>d]", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>")
end

local function register_lsp_handlers()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "double" }
	)
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ update_in_insert = true }
	)

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	for type, icon in pairs(signs) do
		vim.fn.sign_define("DiagnosticSign" .. type, {
			text = icon,
			texthl = "DiagnosticSign" .. type,
			numhl = "",
		})
		vim.fn.sign_define("DiagnosticVirtualText" .. type, {
			text = icon,
			texthl = "DiagnosticVirtualText" .. type,
			numhl = "",
		})
		vim.fn.sign_define("DiagnosticFloating" .. type, {
			text = icon,
			texthl = "DiagnosticFloating" .. type,
			numhl = "",
		})
	end

	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
end

local function document_format(client)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
		vim.api.nvim_command([[augroup END]])
	end
end

local function document_highlight(client)
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

local function update_lsp_capabilities(override)
	override = override or {}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local if_nil = function(val, default)
		if val == nil then
			return default
		end
		return val
	end

	local completionItem = capabilities.textDocument.completion.completionItem

	completionItem.snippetSupport = if_nil(override.snippetSupport, true)
	completionItem.preselectSupport = if_nil(override.preselectSupport, true)
	completionItem.insertReplaceSupport = if_nil(override.insertReplaceSupport, true)
	completionItem.labelDetailsSupport = if_nil(override.labelDetailsSupport, true)
	completionItem.deprecatedSupport = if_nil(override.deprecatedSupport, true)
	completionItem.commitCharactersSupport = if_nil(override.commitCharactersSupport, true)
	completionItem.tagSupport = if_nil(override.tagSupport, { valueSet = { 1 } })
	completionItem.resolveSupport = if_nil(override.resolveSupport, {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	})
	return capabilities
end

local function on_attach(client, bufnr)
	require("virtualtypes").on_attach()
	require("lsp_signature").on_attach()

	bind_key(bufnr)
	register_lsp_handlers()
	document_format(client)
	document_highlight(client)
end

local function setup()
	local installer = require("nvim-lsp-installer")
	installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attach,
			capabilities = update_lsp_capabilities(),
		}
		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
	local lsp = require("lspconfig")
	lsp["sumneko_lua"].setup(require("lua-dev").setup())
end

return { setup = setup }
