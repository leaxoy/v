local function setup()
	-- tree sitter
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "bash", "c", "go", "lua", "rust", "python", "tsx" },
		highlight = {
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = {},
		rainbow = {
			enable = true,
			extended_mode = true,
		},
		refactor = {
			highlight_definitions = { enable = true },
			highlight_current_scope = { enable = true },
			smart_rename = {
				enable = true,
				keymaps = {
					smart_rename = "grr",
				},
			},
			navigation = {
				enable = true,
				keymaps = {
					goto_definition = "gnd",
					list_definitions = "gnD",
					list_definitions_toc = "gO",
					goto_next_usage = "<a-*>",
					goto_previous_usage = "<a-#>",
				},
			},
		},
	})
	require("treesitter-context").setup({
		default = {
			"class",
			"function",
			"method",
			"for", -- These won't appear in the context
			"while",
			"if",
			"switch",
			"case",
		},
		-- If a pattern is missing, *open a PR* so everyone can benefit.
		rust = {
			"impl_item",
		},
	})

	require("vcs").setup()

	-- indent
	require("indent_blankline").setup({
		char = "|",
		buftype_exclude = { "terminal" },
	})

	require("nvim-autopairs").setup({})

	require("nvim-tree").setup({
		diagnostics = { enable = true },
		hijack_cursor = true,
		filters = {
			custom = {
				".DS_Store",
				".git",
				".idea",
				"output",
				"__pycache__",
				"*.pyc",
				".vscode",
			},
		},
		view = {
			-- width of the window, can be either a number (columns) or a string in `%`
			width = 30,
			-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
			side = "left",
			-- if true the tree will resize itself after opening a file
			auto_resize = true,
			lsp_diagnostics = true,
			mappings = {
				-- custom only false will merge the list with the default mappings
				-- if true, it will only use your list to set the mappings
				custom_only = false,
				-- list of mappings to set on the tree manually
				list = {},
			},
		},
	})

	require("bufferline").setup({
		options = {
			numbers = function(opts)
				return string.format("[%s]", opts.ordinal)
			end,
			close_command = "bdelete %d",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "center",
				},
				{
					filetype = "Outline",
					text = "Outline",
					highlight = "Directory",
					text_align = "center",
				},
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics, ctx)
				local icon = level:match("error") and "E" or "W"
				return icon .. "." .. count
			end,
			show_close_icon = false,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = false,
			modified_icon = "●",
			always_show_bufferline = true,
			separator_style = "slant",
			tab_size = 16,
			left_trunc_marker = "",
			right_trunc_marker = "",
		},
	})

	local gps = require("nvim-gps")

	require("lualine").setup({
		options = { theme = "github" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"filename",
				{ gps.get_location, condition = gps.is_available },
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					sections = { "error", "warn", "info", "hint" },
					symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				},
				"diff",
				"filetype",
			},
			lualine_y = { "progress" },
		},
	})
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		show_guides = true,
		show_symbol_details = true,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = {},
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "P",
			rename_symbol = "r",
			code_actions = "a",
		},
	})

	gps.setup({})

	require("github-theme").setup({
		theme_style = "dark_default",
	})
end

return { setup = setup }
