-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()
vim.g.mapleader = " "

require("plugins")
require("option").setup()
require("ui").setup()
require("keybinding").setup()
require("lsp").setup()
require("editor").setup()
require("dbg").setup()
require("vcs").setup()
