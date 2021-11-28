local M = {}

M.setup = function()
	require("autosave").setup({
		enabled = true,
		execution_message = "自动保存: [时间]: "
			.. vim.fn.strftime("%H:%M:%S")
			.. ", [文件]: "
			.. vim.fn.expand("%:p"),
		events = { "InsertLeave", "TextChanged" },
		conditions = {
			exists = true,
			filename_is_not = {},
			filetype_is_not = {},
			modifiable = true,
		},
		write_all_buffers = false,
		on_off_commands = true,
		clean_command_line_interval = 0,
		debounce_delay = 3000,
	})
	require("Comment").setup({
		toggler = {
			line = "<leader>cc",
			block = "<leader>cv",
		},
	})
	require("todo-comments").setup({
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info", alt = { "todo" } },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
		},
	})
	require("neogen").setup({ enabled = true })
end

return M
