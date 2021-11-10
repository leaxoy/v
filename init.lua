-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()

require("plugins")
require("option").setup()
require("mapping").setup()
require("completion").setup()
require("lsp").setup()
require("editor").setup()
require("ui").setup()
require("misc").setup()
-- require("dap").setup()
