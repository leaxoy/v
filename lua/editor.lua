local function setup_edit()
  require("Comment").setup({ mappings = { extra = false } })
  require("todo-comments").setup({
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info", alt = { "todo" } },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
    },
  })
  require("neogen").setup({ enabled = true })
  require("nvim-autopairs").setup({})
end

local function setup_search()
  require("bqf").setup({ auto_reload = true, auto_resize_height = true })
end

local function setup_treesitter()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
  }

  require("nvim-treesitter.configs").setup({
    ensure_installed = vim.g.ts_syntaxes,
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { "org" },
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
    },
  })
end

local function setup_diagnostic()
  vim.diagnostic.config({
    virtual_text = {
      prefix = "", -- Could be '●', '▎', 'x', "■"
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

  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

setup_edit()
setup_search()
setup_treesitter()
setup_diagnostic()
