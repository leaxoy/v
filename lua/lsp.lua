local function bind_key(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Bind buffer keymap
	local wk = require("which-key")
	wk.register({
		g = {
			name = "+LSP",
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP Declaration" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP Type Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP Implementation" },
			r = { "<cmd>lua vim.lsp.buf.references()<cr>", "LSP Reference" },
			h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
			s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "LSP SignatureHelp" },
			f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Formatting" },
			w = {
				name = "+Workspace",
				a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
				r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
				l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspaces" },
			},
			c = {
				n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename" },
				i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "LSP Incoming Calls" },
				o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "LSP Outgoing Calls" },
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code Action" },
			},
			l = {
				name = "+CodeLens",
				d = { "<cmd>lua vim.lsp.codelens.display()" },
			},
			x = {
				name = "+Diagnostics",
				q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Set Diagnostic" },
				d = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Line Diagnostics" },
				["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
				["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic" },
			},
		},
	}, {
		buffer = bufnr,
		prefix = "<space>",
	})
end

local function register_lsp_handlers()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "double" }
	)
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		virtual_text = {
			prefix = "x", -- Could be '●', '▎', 'x', "■"
		},
	})

	local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

	for type, icon in pairs(signs) do
		local hl = "LspDiagnosticsSign" .. type
		local vt = "LspDiagnosticsVirtualText" .. type
		local ft = "LspDiagnosticsFloating" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		vim.fn.sign_define(vt, { text = icon, texthl = vt, numhl = vt })
		vim.fn.sign_define(ft, { text = icon, texthl = ft, numhl = ft })
	end

	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
	vim.cmd([[autocmd CursorHold,CursorHoldI,InsertLeave * lua vim.lsp.codelens.refresh()]])
end

local function document_format(client)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
		vim.api.nvim_command([[augroup END]])
	else
		vim.api.nvim_command([[augroup NeoFormat]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePre <buffer> undojoin | Neoformat]])
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
	require("illuminate").on_attach(client)

	bind_key(bufnr)
	register_lsp_handlers()
	document_format(client)
	document_highlight(client)
end

local function setup()
	local lsp = require("lspconfig")
	lsp["sumneko_lua"].setup(require("lua-dev").setup())

	local installer = require("nvim-lsp-installer")
	installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attach,
			capabilities = update_lsp_capabilities(),
		}
		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end

return { setup = setup }
