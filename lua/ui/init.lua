local M = {}

M.setup = function()
	require("ui/file_explorer").setup()
	require("ui/finder").setup()
	require("ui/outline").setup()
	require("ui/tabline").setup()
	require("ui/terminal").setup()
	require("ui/statusline").setup()
end

return M
