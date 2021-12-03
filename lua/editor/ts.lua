local M = {}
M.setup = function()
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.org = {
		install_info = {
			url = "https://github.com/milisims/tree-sitter-org",
			revision = "main",
			files = { "src/parser.c", "src/scanner.cc" },
		},
		filetype = "org",
	}

	-- require("nvim-treesitter.configs").setup({
	-- 	-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	-- 	highlight = {
	-- 		enable = true,
	-- 		disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
	-- 		additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
	-- 	},
	-- 	ensure_installed = { "org" }, -- Or run :TSUpdate org
	-- })

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"c_sharp",
			"go",
			"java",
			"javascript",
			"kotlin",
			"lua",
			"rust",
			"org",
			"python",
			"toml",
			"tsx",
			"typescript",
		},
		highlight = {
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = { "org" },
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
end
return M
