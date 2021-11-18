-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()
vim.g.mapleader = " "

require("plugins")
require("option").setup()
require("mapping").setup()
require("completion").setup()
require("lsp").setup()
require("editor").setup()
-- require("dap").setup()
require("ui").setup()
require("misc").setup()
