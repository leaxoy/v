vim.o.laststatus = 3
vim.o.updatetime = 250
vim.o.timeoutlen = 250
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.wrap = false
vim.o.numberwidth = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.smartindent = true
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
vim.o.list = false
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↴,space:⋅"
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.cmdheight = 0
vim.o.foldmethod = "indent"
vim.o.foldcolumn = "auto"
vim.o.foldenable = false
vim.o.foldlevelstart = 99
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.confirm = true
vim.wo.colorcolumn = "100"
-- vim.o.spell = true
-- vim.opt.spelllang = { "en_us" }

-- treesitter config
vim.g.ts_syntaxes = {
  "bash",
  "c",
  "cmake",
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
  "vue",
}
-- lsp server config
vim.g.lsp_servers = {
  "asm_lsp",
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "gopls",
  "jdtls",
  "jsonls",
  "kotlin_language_server",
  "omnisharp",
  "pyright",
  "rust_analyzer",
  "r_language_server",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "volar",
  "yamlls",
  "vimls",
}
-- copilot config
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.mapleader = " "
