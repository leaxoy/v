local M = {}

M.autocmds = function()
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "go", "lua", "rs", "typescriptreact", "typescript", "javascriptreact", "javascript", "html", "vue", "kotlin" },
    command = "setlocal tabstop=2 shiftwidth=2 expandtab",
    desc = "set tabstop and shiftwidth for specific filetypes",
  })
end

return M
