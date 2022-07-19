vim.o.mouse = ""
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 250
vim.o.timeoutlen = 200
vim.o.swapfile = false
vim.o.backup = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.numberwidth = 4
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.ruler = true
vim.o.colorcolumn = "100"
vim.o.showmatch = true
vim.o.background = "dark"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.o.showmode = true
vim.o.autoread = true
vim.o.list = true
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↴,space:⋅"
vim.o.showcmd = true
vim.o.wildmenu = true
-- vim.o.cmdheight = 0
vim.o.fillchars = "fold: ,foldopen:,foldsep: ,foldclose:,eob: "
vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.confirm = true
vim.o.termguicolors = true
vim.o.guifont = "JetbrainsMono Nerd Font Mono:h18"
-- vim.o.spell = true
-- vim.o.spelllang = { "en_us" }

vim.o.laststatus = 3

-- netrw
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20
-- vim.g.netrw_list_hide = "^..*"

-- treesitter config
vim.g.ts_syntaxes = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "go",
  "gomod",
  "gowork",
  "java",
  "javascript",
  "lua",
  "rust",
  "org",
  "python",
  "toml",
  "tsx",
  "typescript",
}
-- lsp server config
vim.g.lsp_servers = {
  "bashls",
  "clangd",
  "cmake",
  "gopls",
  "jdtls",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "yamlls",
}
-- copilot config
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.mapleader = " "
vim.g.copilot_filetypes = {
  netrw = false,
  qf = false,
  TelescopePrompt = false,
  TelescopeResults = false,
  NvimTree = false,
  Outline = false,
  DressingInput = false,
  SearchBox = false,
}
