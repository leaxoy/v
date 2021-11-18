local function setup()
	require("autosave").setup({
		enabled = true,
		execution_message = "AutoSave: [time]: "
			.. vim.fn.strftime("%H:%M:%S")
			.. ", [file]: "
			.. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
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
		debounce_delay = 1000,
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
	require("hlslens").setup({
		calm_down = true,
		nearest_only = true,
		nearest_float_when = "always",
		virt_priority = 1,
	})
	require("marks").setup({})
end

return { setup = setup }
