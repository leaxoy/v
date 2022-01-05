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

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"c_sharp",
			"go",
			"gomod",
			"gowork",
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
		rainbow = {
			enable = true,
			extended_mode = true,
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
