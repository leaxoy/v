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
        color = { fg = "#77b787", gui = "bold" },
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

if vim.fn.has("nvim-0.8") then
  local navic = require("nvim-navic")
  _G.win_title = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    local ft2title = {
      NvimTree = "%=文件管理器%=",
      netrw = "%=文件管理器%=",
      Outline = "%=符号大纲%=",
      ["neotest-summary"] = "%=测试报告%=",
      toggleterm = "%=终端%=",
    }
    local title = ft2title[ft]
    if title ~= nil then return title end
    local f = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    return navic.get_location() and f .. " ▸ " .. navic.get_location() or f
  end
  vim.opt.winbar = "%{%v:lua.win_title()%}"
end
