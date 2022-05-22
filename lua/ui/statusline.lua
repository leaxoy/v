local M = {}

M.setup = function()
  require("lualine").setup({
    options = {
      theme = "auto",
      icon_enabled = true,
      component_separators = { left = "→", right = "←" },
      section_separators = { left = "", right = "" },
      always_divide_middle = true,
      globalstatus = true,
    },
    extensions = { "nvim-tree", "toggleterm", "symbols-outline", "quickfix" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        "diff",
        -- { "filename", path = 1 },
        -- { gps.get_location, condition = gps.is_available },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info", "hint" },
          symbols = { error = " ", warn = " ", hint = " ", info = " " },
          diagnostics_color = {
            -- Same values like general color option can be used here.
            error = "DiagnosticError", -- changes diagnostic's error color
            warn = "DiagnosticWarn", -- changes diagnostic's warn color
            info = "DiagnosticInfo", -- Changes diagnostic's info color
            hint = "DiagnosticHint", -- Changes diagnostic's hint color
          },
          colored = true,
        },
        -- "diff",
      },
      lualine_y = { { "filetype" } },
      lualine_z = { "progress", "location" },
    },
  })

  local gps = require("nvim-gps")

  gps.setup({})

  if vim.fn.has("nvim-0.8") then
    _G.gps_location = function()
      local f = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
      return gps.is_available() and gps.get_location() ~= "" and f .. " # " .. gps.get_location() or f
    end
    vim.opt.winbar = "%{%v:lua.gps_location()%}"

    vim.api.nvim_create_autocmd("CursorMoved,CursorMovedI", {
      pattern = "*",
      command = "redrawstatus"
    })
  end

end

return M
