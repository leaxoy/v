local M = {}
M.setup = function()
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
end
return M
