function PeekDefinition()
	local function preview_location_callback(_, result)
		if result == nil or vim.tbl_isempty(result) then
			return nil
		end
		vim.lsp.util.preview_location(result[1], { border = "rounded" })
	end
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

function PeekImplementation()
	local function preview_location_callback(_, result)
		if result == nil or vim.tbl_isempty(result) then
			return nil
		end
		vim.lsp.util.preview_location(result, { border = "rounded" })
	end
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/implementation", params, preview_location_callback)
end

local function setup(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- Use LSP as the handler for omnifunc.
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	--    See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Bind buffer keymap
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local wk = require("which-key")
	wk.register({
		g = {
			name = "+LSP",
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP Definition" },
			p = { "<cmd>lua PeekDefinition()<cr>", "LSP Peek Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP Declaration" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP Type Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP Implementation" },
			I = { "<cmd>lua PeekImplementation()<cr>", "LSP Peek Implementation" },
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
				name = "+Call Hierarchy",
				-- n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename" },
				n = { "<cmd>lua require'lspactions'.rename()<cr>", "LSP Rename" },
				i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "LSP Incoming Calls" },
				o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "LSP Outgoing Calls" },
				-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code Action" },
				a = { "<cmd>lua require'lspactions'.code_action()<cr>", "LSP Code Action" },
			},
			l = {
				name = "+CodeLens",
				d = { "<cmd>lua vim.lsp.codelens.display()<cr>", "LSP Display CodeLens" },
				r = { "<cmd>lua vim.lsp.codelens.run()<cr>", "LSP Run CodeLens" },
				f = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "LSP Refresh CodeLens" },
			},
			x = {
				name = "+Diagnostics",
				q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Set Diagnostic" },
				d = {
					"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({show_header=false, focusable=false, border='rounded'})<cr>",
					"Line Diagnostics",
				},
				["["] = { "<cmd>lua require'lspactions'.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
				["]"] = { "<cmd>lua require'lspactions'.diagnostic.goto_next()<cr>", "Next Diagnostic" },
			},
		},
	}, {
		buffer = bufnr,
		prefix = "<leader>",
	})
end

return { setup = setup }
