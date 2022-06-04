function ToggleLazygit()
  local lazygit = require("toggleterm.terminal").Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { border = "double" },
  })
  lazygit:toggle()
end

local function setup()
  local wk = require("which-key")
  wk.register({
    b = {
      name = "+Buffer",
      ["h"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer" },
      ["l"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
      ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Goto Buffer 1" },
      ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Goto Buffer 2" },
      ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Goto Buffer 3" },
      ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Goto Buffer 4" },
      ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Goto Buffer 5" },
      ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Goto Buffer 6" },
      ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Goto Buffer 7" },
      ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Goto Buffer 8" },
      ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Goto Buffer 9" },
    },
    c = {
      name = "+Change & Comment",
      g = { "<cmd>lua require'neogen'.generate()<cr>", "Generate Doc" },
    },
    f = {
      name = "Magic Finder",
      w = { "<cmd>Telescope<cr>", "Open Telescope Window" },
      f = { "<cmd>Telescope find_files<cr>", "File Finder" },
      l = { "<cmd>Telescope file_browser<cr>", "File Browser" },
      g = { "<cmd>Telescope live_grep_raw<cr>", "Live Grep" },
      c = { "<cmd>Telescope grep_string<cr>", "Grep String" },
      b = { "<cmd>Telescope buffers<cr>", "All Buffers" },
      t = { "<cmd>TodoTelescope<cr>", "Todo List" },
      d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      r = { "<cmd>Telescope lsp_references<cr>", "[LSP] References" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "[LSP] Implementations" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "[LSP] Document Symbols" },
      p = { "<cmd>Telescope project display_type=full<cr>", "List Projects" },
      e = { "<cmd>Telescope packer<cr>", "List Packer Plugins" },
    },
    l = {
      name = "+LSP Manage",
      r = { "<cmd>LspRestart<cr>", "Restart Server" },
      i = { "<cmd>LspInfo<cr>", "Show Info" },
      s = { "<cmd>LspInstallInfo<cr>", "Manage Servers" },
    },
    p = {
      name = "+Preview",
      m = { "<cmd>Glow<cr>", "Markdown" },
    },
    v = {
      name = "+VCS",
      d = { "<cmd>Gitsigns diffthis<cr>", "Diff this file" },
      p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview diff" },
      v = { "<cmd>lua ToggleLazygit()<cr>", "LazyGit" },
    },
    t = {
      name = "+Debug & Test",
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Eval Expression" },
      f = { "<cmd>lua require'dapui'.float_element('stacks')<cr>", "Show Floating Window" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      n = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },

      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    },
    u = {
      name = "+User Interface",
      d = { "<cmd>lua require'dapui'.toggle()<cr>", "Debug & Test" },
      f = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
      s = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" },
    },
    w = {
      name = "+Window",
      c = { "<cmd>wincmd x<cr>", "Close Current Window" },
      o = { "<cmd>wincmd o<cr>", "Close Other Window" },
      v = { "<cmd>vsplit<cr>", "Split Vertically" },
      s = { "<cmd>split<cr>", "Split Horizonally" },
      h = { "<c-w>10<", "Decrease width" },
      j = { "<c-w>10+", "Increase height" },
      k = { "<c-w>10-", "Decrease height" },
      l = { "<c-w>10>", "Increase width" },
      ["="] = { "<c-w>=", "Equally high and wide" },
    },
    x = {
      name = "+Diagnostic",
      t = { "<cmd>TodoQuickFix<cr>", "Workspace Todos" },
      b = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Buffer Diagnostic" },
      w = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Workspace Diagnostic" },
      x = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show Line Diagnostic" },
      l = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      h = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    },
  }, {
    mode = "n",
    prefix = "<leader>",
  })
  wk.register({
    d = {
      name = "+Delete",
      H = { "d^", "Start of line" },
      L = { "d$", "End of line" },
      ['"'] = { 'di"', "double quoted string" },
      ["'"] = { "di'", "single quoted string" },
      ["[["] = { "di[", "content between matched []" },
      ["]]"] = { "di]", "content between matched []" },
      ["("] = { "dib", "content between matched ()" },
      [")"] = { "dib", "content between matched ()" },
      ["{"] = { "diB", "content between matched {}" },
      ["}"] = { "diB", "content between matched {}" },
    },
    gim = { "<cmd>Telescope goimpl<cr>", "Go Impl Interface" },
    H = { "^", "Start of line" },
    L = { "$", "End of line" },
    J = { "10j", "Jump 10 Line Down" },
    K = { "10k", "Jump 10 Line Up" },
    [";"] = { ":", "Command Mode" },
    ["#"] = { "#<cmd>lua require('hlslens').start()<cr>", "Search" },
    ["<c-s>"] = { "<cmd>w<cr>", "Save buffer" },
    ["<c-x>"] = { "<cmd>lua require('bufdelete').bufdelete(0)<cr>", "Close Current Buffer" },
    ["<c-h>"] = { "<cmd>wincmd h<cr>", "Goto Left Window" },
    ["<c-j>"] = { "<cmd>wincmd j<cr>", "Goto Bottom Window" },
    ["<c-k>"] = { "<cmd>wincmd k<cr>", "Goto Top Window" },
    ["<c-l>"] = { "<cmd>wincmd l<cr>", "Goto Right Window" },
  }, { mode = "n" })
  wk.register({
    ["jk"] = { "<Esc>", "Escape Insert Mode" },
    ["<c-h>"] = { "<c-o>^", "Start of line" },
    ["<c-l>"] = { "<c-o>$", "End of line" },
    ["<c-j>"] = { "<c-o>10j", "Jump 10 Line Down" },
    ["<c-k>"] = { "<c-o>10k", "Jump 10 Line Up" },
    ["<c-t>"] = { "<c-o><cmd>ToggleTerm<cr>", "Toggle Terminal" },
    ["<c-u>"] = { "<c-o>u", "Undo" },
    ["<c-y>"] = { "<c-o>yy", "Copy Line" },
    ["<c-p>"] = { "<c-o>p", "Paste" },
    ["<c-s>"] = { "<c-o><cmd>w<cr>", "Save buffer" },
    ["<c-x>"] = { "<c-o><cmd>lua require('bufdelete').bufdelete(0)<cr>", "Close Current Buffer" },
  }, {
    mode = "i",
  })
  vim.keymap.set("", "<ScrollWheelUp>", "<Nop>", { noremap = true, silent = true })
  vim.keymap.set("", "<ScrollWheelDown>", "<Nop>", { noremap = true, silent = true })
  vim.keymap.set("", "<S-ScrollWheelUp>", "<Nop>", { noremap = true, silent = true })
  vim.keymap.set("", "<S-ScrollWheelDown>", "<Nop>", { noremap = true, silent = true })
end

return { setup = setup }
