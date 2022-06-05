-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()
vim.g.mapleader = " "

require("impatient").enable_profile()

require("plugins")
require("option").setup()
require("commands")
require("diagnostic")
require("ui").setup()
require("keybinding")
require("lsp").setup({ lsp_servers = vim.g.lsp_servers })
require("editor").setup({ ts_syntaxes = vim.g.ts_syntaxes })
require("dbg")
require("vcs")
