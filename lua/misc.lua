local function setup()
	require("telescope").setup({
		defaults = {
			-- initial_mode = "normal",
			prompt_prefix = "🔍 ",
		},
	})
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
	require("auto-session").setup({
		log_level = "info",
		auto_session_enable_last_session = false,
		auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_session_enabled = true,
		auto_save_enabled = nil,
		auto_restore_enabled = nil,
		auto_session_suppress_dirs = nil,
	})
	require("nvim-startup").setup({
		startup_file = "/tmp/nvim-startuptime", -- sets startup log path (string)
		message = "Whoa! those {} are pretty fast", -- sets a custom message (string | function)
		-- message = function(time) -- function-based custom message
		-- time < 100 and 'Just {}? really good!' or 'Those {} can get faster'
		-- end
	})
end

return { setup = setup }
