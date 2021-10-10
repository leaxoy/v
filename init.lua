-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()

require('plugins')

require("option").setup()
require("completion").setup()
require("mapping").setup()
require("ui").setup()
require("misc").setup()

require('lsp_signature').setup {bind = true}
require("nvim-lightbulb").update_lightbulb {
    sign = {enabled = true, priority = 10},
    float = {enabled = true, text = "💡", win_opts = {}},
    virtual_text = {enabled = true, text = "💡", hl_mode = "replace"},
    status_text = {enabled = true, text = "💡", text_unavailable = ""}
}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
