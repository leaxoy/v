-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()

-- vim.g.theme = "gruvbox-material"
vim.g.theme = "vscode"

require("plugins")
require("impatient").enable_profile()
require("option")
pcall(require, "local") -- try load local config, can override option
require("commands")
require("diagnostic")
require("ui")
require("keybinding")
require("lsp").setup()
require("editor")
require("dbg")
require("vcs")
