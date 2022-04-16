local M = {}

M.setup = function()
	local gps = require("nvim-gps")

	gps.setup({})

	require("lualine").setup({
		options = {
			theme = "auto",
			icon_enabled = true,
			component_separators = { left = ">", right = "<" },
			section_separators = { left = "", right = "" },
			always_divide_middle = true,
			globalstatus = true,
		},
		extensions = { "nvim-tree", "toggleterm", "symbols-outline", "quickfix" },
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
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = { error = " ", warn = " ", hint = " ", info = " " },
					diagnostics_color = {
						-- Same values like general color option can be used here.
						error = "DiagnosticError", -- changes diagnostic's error color
						warn = "DiagnosticWarn", -- changes diagnostic's warn color
						info = "DiagnosticInfo", -- Changes diagnostic's info color
						hint = "DiagnosticHint", -- Changes diagnostic's hint color
					},
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
