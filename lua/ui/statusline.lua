require("lualine").setup({
  options = {
    theme = "auto",
    icon_enabled = true,
    component_separators = {
      -- left = "→",
      -- right = "←",
      left = "",
      right = "",
    },
    section_separators = { left = "", right = "" },
    always_divide_middle = false,
    globalstatus = true,
  },
  extensions = { "nvim-tree", "toggleterm", "quickfix" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", file_status = true, path = 1 } },
    lualine_c = {
      { function() return "%=" end },
      { -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#dc322f", gui = "bold" },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        -- symbols = { error = " ", warn = " ", hint = " ", info = " " },
        -- symbols = { error = " ", warn = " ", info = " " },
        symbols = { error = " ", warn = " ", hint = " ", info = " " },
        diagnostics_color = {
          -- Same values like general color option can be used here.
          error = "DiagnosticError", -- changes diagnostic's error color
          warn = "DiagnosticWarn", -- changes diagnostic's warn color
          info = "DiagnosticInfo", -- Changes diagnostic's info color
          hint = "DiagnosticHint", -- Changes diagnostic's hint color
        },
        colored = true,
      },
    },
    lualine_y = { "diff", "branch" },
    lualine_z = { "progress", "location" },
  },
})

if vim.fn.has("nvim-0.8") then
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter", "CursorMoved" },
    {
      pattern = "*",
      callback = function()
        local excludes = { "", "toggleterm", "prompt", "NvimTree", "help", "netrw", "lspsagaoutline", "qf", "packer" }
        if vim.api.nvim_win_get_config(0).zindex or vim.tbl_contains(excludes, vim.bo.filetype) then
          vim.wo.winbar = ""
        else
          local win_text
          local status, symbol = pcall(require, "lspsaga.symbolwinbar")
          if status then
            win_text = symbol:get_symbol_node() or "..."
          else
            win_text = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
          end
          vim.wo.winbar = win_text
        end
      end
    })
end
