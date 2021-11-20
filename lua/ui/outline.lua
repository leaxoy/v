local M = {}

M.title = function()
	return "Symbol Outline"
end

M.filetype = function()
	return "Outline"
end

M.setup = function()
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		show_guides = true,
		show_symbol_details = true,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = nil,
			goto_location = "<cr>",
			focus_location = "o",
			hover_symbol = "<c-space>",
			toggle_preview = "K",
			rename_symbol = "r",
			code_actions = "a",
		},
	})
end

return M
