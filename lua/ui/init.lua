local M = {}

M.setup = function()
	require("nvim-web-devicons").setup({ default = true })
	require("ui/file_explorer").setup()
	require("ui/finder").setup()
	require("ui/tabline").setup()
	require("ui/terminal").setup()
	require("ui/statusline").setup()
	require("ui/theme").setup()
end

return M
