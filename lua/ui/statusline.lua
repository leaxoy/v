local M = {}

M.setup = function()
	local gps = require("nvim-gps")

	gps.setup({})

	require("lualine").setup({
		-- options = { theme = "gruvbox-material" },
		options = {
			-- theme = "vscode",
			-- disabled_filetypes = { "NvimTree", "Outline" },
			theme = "auto",
			component_separators = { left = ">", right = "<" },
			section_separators = { left = "", right = "" },
			always_divide_middle = true,
		},
		extensions = { "nvim-tree", "toggleterm" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"filename",
				{ gps.get_location, condition = gps.is_available },
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					sections = { "error", "warn", "info", "hint" },
					symbols = { error = "E", warn = "W", info = "I", hint = "H" },
					-- diagnostics_color = {
					-- 	-- Same values like general color option can be used here.
					-- 	error = "DiagnosticError", -- changes diagnostic's error color
					-- 	warn = "DiagnosticWarn", -- changes diagnostic's warn color
					-- 	info = "DiagnosticInfo", -- Changes diagnostic's info color
					-- 	hint = "DiagnosticHint", -- Changes diagnostic's hint color
					-- },
					colored = true,
				},
				"diff",
				"filetype",
			},
			lualine_y = { "progress" },
		},
	})
end

return M
