local M = {}

M.setup = function()
	require("toggleterm").setup({
		open_mapping = [[<c-t>]],
		size = function(term)
			if term.direction == "horizontal" then
				return 30
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		hidden = true,
		hide_numbers = true,
		-- direction = "tab",
		direction = "float",
		shade_terminals = true,
		float_opts = { border = "double" },
	})
	require("nvim-startup").setup({
		startup_file = "/tmp/nvim-startuptime", -- sets startup log path (string)
		message = "Whoa! those {} are pretty fast", -- sets a custom message (string | function)
		-- message = function(time) -- function-based custom message
		-- time < 100 and 'Just {}? really good!' or 'Those {} can get faster'
		-- end
	})
end

return M
