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
    always_divide_middle = true,
    globalstatus = true,
  },
  extensions = { "nvim-tree", "toggleterm", "symbols-outline", "quickfix" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { function() return "%=" end },
      { -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#145555", gui = "bold" },
      },
      { "lsp_progress", display_components = { "lsp_client_name", { "title", "percentage", "message" } } }
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
    lualine_y = { { "filetype" } },
    lualine_z = { "progress", "location" },
  },
})

local navic = require("nvim-navic")
if vim.fn.has("nvim-0.8") then
  _G.win_title = function()
    local buf_id = vim.api.nvim_win_get_buf(0);
    local buf_ft = vim.api.nvim_buf_get_option(buf_id, "filetype")
    if buf_ft == "NvimTree" then
      -- return "%=File Explorer%="
      return "%=文件管理器%="
    elseif buf_ft == "Quickfix" then
      return "Quickfix"
    elseif buf_ft == "Outline" then
      return "%=符号大纲%="
    elseif buf_ft == "neotest-summary" then
      return "%=测试报告%="
    elseif buf_ft == "toggleterm" then
      return "%=终端%="
    end
    local f = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    return navic.get_location() and f .. " ▸ " .. navic.get_location() or f
  end
  vim.opt.winbar = "%{%v:lua.win_title()%}"
end
