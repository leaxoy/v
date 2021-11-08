-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()

require("plugins")
require("option").setup()
require("completion").setup()
require("mapping").setup()
require("ui").setup()
require("misc").setup()
require("lsp").setup()
require("editor").setup()
-- require("dap").setup()
