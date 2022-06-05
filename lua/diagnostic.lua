vim.diagnostic.config({
  virtual_text = {
    prefix = "■ ", -- Could be '●', '▎', 'x', "■"
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.ERROR,
    }
  },
  signs = true,
  underline = true,
  float = { show_header = true, focus = false, border = "double" },
  update_in_insert = true,
  severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    local opts = {
      focusable = false,
      header = "",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "if_many",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(opts)
  end,
})
