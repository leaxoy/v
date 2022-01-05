local M = {}
M.setup = function()
	require("telescope").setup({
		defaults = { prompt_prefix = "🔍 " },
		extensions = {
			file_browser = {},
		},
	})
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("project")
	require("telescope").load_extension("dap")
	require("telescope").load_extension("goimpl")
end

return M
