local function setup()
	vim.o.number = true
	vim.o.relativenumber = true
	vim.o.tabstop = 4
	vim.o.shiftwidth = 4
	vim.o.expandtab = true
	vim.o.termguicolors = true
	vim.o.cursorline = true
	vim.o.completeopt = "menu,menuone,noselect"
	vim.o.autoindent = true
	vim.o.showmatch = true
	vim.o.ruler = true
	-- vim.o.foldmethod = "expr"
	-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

	-- You will likely want to reduce updatetime which affects CursorHold
	-- note: this setting is global and should be set only once
	vim.o.updatetime = 200
	vim.o.background = "dark"

	-- nvim tree config
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_highlight_opened_files = 1
	vim.g.nvim_tree_add_trailing = 1
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_git_hl = 1

	-- neo format config
	vim.g.neoformat_basic_format_align = 1
	vim.g.neoformat_enabled_python = { "black" }
	vim.g.neoformat_enabled_go = { "gofumpt" }
	vim.g.neoformat_enabled_lua = { "stylua" }
	vim.g.neoformat_enabled_kotlin = { "ktlint" }
end

return { setup = setup }
