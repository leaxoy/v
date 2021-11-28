local M = {}

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

M.setup = function()
	require("toggleterm").setup({
		open_mapping = [[<c-t>]],
		size = function(term)
			if term.direction == "horizontal" then
				return 16
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		hidden = true,
		hide_numbers = true,
		direction = "tab",
		-- direction = "float",
		shade_terminals = true,
		float_opts = { border = "double" },
	})
	vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
	require("nvim-startup").setup({
		startup_file = "/tmp/nvim-startuptime", -- sets startup log path (string)
		message = "Whoa! those {} are pretty fast", -- sets a custom message (string | function)
		-- message = function(time) -- function-based custom message
		-- time < 100 and 'Just {}? really good!' or 'Those {} can get faster'
		-- end
	})
end

return M
