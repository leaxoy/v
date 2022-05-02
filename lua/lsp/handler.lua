local function setup()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "double" }
  )

  vim.diagnostic.config({
    virtual_text = {
      prefix = "■ ", -- Could be '●', '▎', 'x', "■"
      source = "if_many",
    },
    signs = true,
    float = { show_header = true, focus = false, border = "double" },
    underline = true,
    update_in_insert = true,
    severity_sort = false,
  })

  local sign = function(hl, icon)
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    sign("Diagnostic" .. type, icon)
    sign("DiagnosticSign" .. type, icon)
    sign("DiagnosticVirtualText" .. type, icon)
    sign("DiagnosticFloating" .. type, icon)
    sign("DiagnosticUnderline" .. type, icon)
  end
end

return { setup = setup }
