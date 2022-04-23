local M = {}
M.setup = function()
	require("telescope").setup({
		defaults = { prompt_prefix = "🔍 " },
		extensions = {
			file_browser = {},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
	})
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("project")
	require("telescope").load_extension("dap")
	require("telescope").load_extension("goimpl")
	require("telescope").load_extension("refactoring")
	require("telescope").load_extension("ui-select")
end

return M
