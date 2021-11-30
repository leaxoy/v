local function setup()
	local location_config = {
		open_list = true,
		jump_to_result = true,
		jump_to_list = false,
		loclist = false,
		always_qf = false,
		transform = function(result)
			return result
		end,
	}
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "double" }
	)
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		virtual_text = {
			prefix = "● ", -- Could be '●', '▎', 'x', "■"
		},
	})
	vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(require("lspactions").codeaction, {})
	vim.lsp.handlers["textDocument/references"] = vim.lsp.with(require("lspactions").references, location_config)
	vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(require("lspactions").definition, location_config)
	vim.lsp.handlers["textDocument/declaration"] = vim.lsp.with(require("lspactions").declaration, location_config)
	vim.lsp.handlers["textDocument/implementation"] = vim.lsp.with(
		require("lspactions").implementation,
		location_config
	)

	local signs = { Error = "", Warning = "", Hint = "", Information = "" }

	local sign = function(hl, icon)
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	if vim.fn.has("nvim-0.5.1") then
		for type, icon in pairs(signs) do
			sign("LspDiagnosticsSign" .. type, icon)
			sign("LspDiagnosticsVirtualText" .. type, icon)
			sign("LspDiagnosticsFloating" .. type, icon)
			sign("LspDiagnosticsUnderline" .. type, icon)
		end
	else
		for type, icon in pairs(signs) do
			sign("DiagnosticSign" .. type, icon)
			sign("DiagnosticVirtualText" .. type, icon)
			sign("DiagnosticFloating" .. type, icon)
			sign("DiagnosticUnderline" .. type, icon)
		end
	end

	vim.cmd(
		[[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({show_header=false, focusable=false, border="rounded"})]]
	)
end

return { setup = setup }
