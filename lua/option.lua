local function setup()
	-- You will likely want to reduce updatetime which affects CursorHold
	-- note: this setting is global and should be set only once
	vim.o.updatetime = 250
	vim.o.timeoutlen = 250

	vim.o.number = true
	vim.o.relativenumber = true

	-- Indent Config
	vim.o.tabstop = 4
	vim.o.shiftwidth = 4
	vim.o.expandtab = true
	vim.o.autoindent = true

	-- Search Config
	vim.o.hlsearch = true
	vim.o.incsearch = true
	vim.o.ignorecase = true
	vim.o.smartcase = true

	vim.o.termguicolors = true
	vim.o.cursorline = true
	vim.o.showmatch = true
	vim.o.ruler = true
	vim.o.background = "dark"
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
	vim.o.showmode = false
	vim.o.autoread = true
	-- 不可见字符的显示，这里只把空格显示为一个点
	vim.o.list = false
	vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↴,space:⋅"
	-- 补全增强
	vim.o.wildmenu = true
	-- vim.o.foldmethod = "expr"
	-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

	vim.o.confirm = true
	vim.wo.colorcolumn = "100"

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

	-- copilot config
	vim.g.copilot_no_tab_map = true
	vim.g.copilot_assume_mapped = true
end

return { setup = setup }
