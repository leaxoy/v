local M = {}

M.setup = function()
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
