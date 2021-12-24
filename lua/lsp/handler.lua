local function setup()
	local loc_conf = {
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
	vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(require("lspactions").codeaction, {})
	vim.lsp.handlers["textDocument/references"] = vim.lsp.with(require("lspactions").references, loc_conf)
	vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(require("lspactions").definition, loc_conf)
	vim.lsp.handlers["textDocument/declaration"] = vim.lsp.with(require("lspactions").declaration, loc_conf)
	vim.lsp.handlers["textDocument/implementation"] = vim.lsp.with(require("lspactions").implementation, loc_conf)

	vim.diagnostic.config({
		virtual_text = {
			prefix = "■ ", -- Could be '●', '▎', 'x', "■"
			source = "if_many",
		},
		signs = true,
		float = { show_header = false, focus = false, border = "rounded" },
		underline = true,
		update_in_insert = true,
		severity_sort = false,
	})

	local sign = function(hl, icon)
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
	local signs = { Error = "", Warn = "", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		sign("Diagnostic" .. type, icon)
		sign("DiagnosticSign" .. type, icon)
		sign("DiagnosticVirtualText" .. type, icon)
		sign("DiagnosticFloating" .. type, icon)
		sign("DiagnosticUnderline" .. type, icon)
	end

	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {scope='cursor'})]])
end

return { setup = setup }
