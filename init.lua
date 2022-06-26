-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()

vim.g.theme = "gruvbox-material"

require("plugins")
require("impatient").enable_profile()
require("option")
pcall("require", "local") -- try load local config, can override option
require("commands")
require("diagnostic")
require("ui")
require("keybinding")
require("lsp").setup({ lsp_servers = vim.g.lsp_servers })
require("editor").setup({ ts_syntaxes = vim.g.ts_syntaxes })
require("dbg")
require("vcs")
