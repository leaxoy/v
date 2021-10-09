require('plugins')

require("option").setup{}
require("completion").setup{}
require("mapping").setup{}
require("ui").setup{}
require("misc").setup{}

require('lsp_signature').setup{ bind = true }
require("nvim-lightbulb").update_lightbulb{}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

