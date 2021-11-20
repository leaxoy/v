local M = {}
M.setup = function()
	require("nvim-autopairs").setup({})
	require("indent_blankline").setup({
		char = "|",
		buftype_exclude = { "terminal" },
	})

	require("bqf").setup({})
end
return M
