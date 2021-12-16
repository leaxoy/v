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
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
			p = { "<cmd>lua PeekDefinition()<cr>", "Peek Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto Type Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementations" },
			I = { "<cmd>lua PeekImplementation()<cr>", "Peek Implementations" },
			r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
			h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Peek Hover" },
			s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Peek SignatureHelp" },
			f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format Document" },
			w = {
				name = "+Workspace",
				a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
				r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
				l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspaces" },
			},
			c = {
				name = "+Call Hierarchy",
				-- n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				n = { "<cmd>lua require'lspactions'.rename()<cr>", "Rename" },
				i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Incoming Calls" },
				o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "Outgoing Calls" },
				-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				a = { "<cmd>lua require'lspactions'.code_action()<cr>", "Code Action" },
			},
			l = {
				name = "+CodeLens",
				d = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display CodeLens" },
				r = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run CodeLens" },
				f = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh CodeLens" },
			},
			x = {
				name = "+Diagnostics",
				q = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Set Diagnostic List" },
				d = {
					"<cmd>lua vim.diagnostic.open_float(nil, {scope='line', show_header=false, focus=false, border='rounded'})<cr>",
					"SHow Line Diagnostics",
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
