local M = {}

M.setup = function()
  vim.diagnostic.config({
    -- disable virtual_text by default
    -- virtual_text = {
    --   prefix = "x ", -- Could be '●', '▎', 'x', "■"
    --   source = "if_many",
    -- },
    virtual_text = false,
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
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(opts)
    end,
  })
end

return M
