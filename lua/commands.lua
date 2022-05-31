local M = {}

M.autocmds = function()
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = {
      "go",
      "html",
      "javascriptreact",
      "javascript",
      "kotlin",
      "lua",
      "rust",
      "typescriptreact",
      "typescript",
      "vue",
    },
    command = "setlocal tabstop=2 shiftwidth=2 expandtab",
    desc = "set tabstop and shiftwidth for specific filetypes",
  })
end

return M
