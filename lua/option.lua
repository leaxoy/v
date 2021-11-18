local function setup()
	-- You will likely want to reduce updatetime which affects CursorHold
	-- note: this setting is global and should be set only once
	vim.o.updatetime = 250

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
	vim.o.background = "dark"
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
	-- vim.o.foldmethod = "expr"
	-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

	-- theme config
	-- vim.g.gruvbox_material_background = "hard"
	-- vim.g.gruvbox_material_enable_italic = 1
	-- vim.g.gruvbox_material_enable_bold = 1
	-- vim.g.gruvbox_material_transparent_background = 1
	-- vim.g.gruvbox_material_diagnostic_text_highlight = 1
	-- vim.g.gruvbox_material_diagnostic_line_highlight = 1
	-- vim.g.gruvbox_material_diagnostic_virtual_text = "grey" -- "grey" or "colored"
	-- vim.g.gruvbox_material_current_word = "bold" -- `'grey background'`, `'bold'`, `'underline'`, `'italic'`
	-- vim.cmd([[colorscheme gruvbox-material]])

	vim.g.vscode_style = "dark"
	vim.cmd([[colorscheme vscode]])

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
