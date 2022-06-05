vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    "go",
    "html",
    "javascriptreact",
    "javascript",
    "json",
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    -- require("lsp_signature").on_attach({ bind = true, handler_opts = { border = "rounded" } }, buf)

    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    client.offset_encoding = "utf-16"
    require("lsp").activate(client, buf)
  end,
  desc = "setup lsp functions"
})
