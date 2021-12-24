local M = {}

M.title = function()
	return "Symbol Outline"
end

M.filetype = function()
	return "Outline"
end

M.setup = function()
	require("symbols-outline").setup({
		width = 50,
		-- highlight_hovered_item = true,
		-- auto_preview = true,
		-- show_guides = true,
		-- show_symbol_details = true,
		-- relative_width = true,
		-- width = 30,
		-- keymaps = { -- These keymaps can be a string or a table for multiple keys
		-- 	close = nil,
		-- 	goto_location = "<cr>",
		-- 	focus_location = "o",
		-- 	hover_symbol = "<c-space>",
		-- 	toggle_preview = "K",
		-- 	rename_symbol = "r",
		-- 	code_actions = "a",
		-- },
	})
end

return M
