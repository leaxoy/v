-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()
vim.g.mapleader = " "

require("impatient").enable_profile()

require("plugins")
require("option").setup()
require("commands").autocmds()
require("diagnostic").setup()
require("ui").setup()
require("keybinding").setup()
require("lsp").setup()
require("editor").setup()
require("dbg").setup()
require("vcs").setup()
