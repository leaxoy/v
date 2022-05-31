return {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
  ["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
    require("notify")({ result.message }, lvl, {
      title = "LSP | " .. client.name,
      timeout = 10000,
      keep = function()
        return lvl == "ERROR" or lvl == "WARN"
      end,
    })
  end
}
