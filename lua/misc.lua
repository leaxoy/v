local function setup()
	require("telescope").setup({
		defaults = {
			-- initial_mode = "normal",
			prompt_prefix = "🔍 ",
		},
		extensions = {
			hop = {
				-- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
				keys = {
					"a",
					"s",
					"d",
					"f",
					"g",
					"h",
					"j",
					"k",
					"l",
					";",
					"q",
					"w",
					"e",
					"r",
					"t",
					"y",
					"u",
					"i",
					"o",
					"p",
					"A",
					"S",
					"D",
					"F",
					"G",
					"H",
					"J",
					"K",
					"L",
					":",
					"Q",
					"W",
					"E",
					"R",
					"T",
					"Y",
					"U",
					"I",
					"O",
					"P",
				},
				-- Highlight groups to link to signs and lines; the below configuration refers to demo
				-- sign_hl typically only defines foreground to possibly be combined with line_hl
				sign_hl = { "WarningMsg", "Title" },
				-- optional, typically a table of two highlight groups that are alternated between
				line_hl = { "CursorLine", "Normal" },
				-- options specific to `hop_loop`
				-- true temporarily disables Telescope selection highlighting
				clear_selection_hl = false,
				-- highlight hopped to entry with telescope selection highlight
				-- note: mutually exclusive with `clear_selection_hl`
				trace_entry = true,
				-- jump to entry where hoop loop was started from
				reset_selection = true,
			},
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
	require("nvim-startup").setup({
		startup_file = "/tmp/nvim-startuptime", -- sets startup log path (string)
		message = "Whoa! those {} are pretty fast", -- sets a custom message (string | function)
		-- message = function(time) -- function-based custom message
		-- time < 100 and 'Just {}? really good!' or 'Those {} can get faster'
		-- end
	})
end

return { setup = setup }
