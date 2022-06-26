local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts, { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function ToggleLazygit()
  local lazygit = require("toggleterm.terminal").Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { border = "double" },
  })
  lazygit:toggle()
end

-- builtin start
-- builtin end

-- Window
require("key-menu").set("n", "<leader>w", { desc = "Window" })
map("n", "<leader>wc", "<cmd>wincmd x<cr>", { desc = "Close Current Window" })
map("n", "<leader>wo", "<cmd>wincmd o<cr>", { desc = "Close Other Window" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertically" })
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split Horizonally" })
map("n", "<leader>wh", "<c-w>10<<cr>", { desc = "Decrease Width" })
map("n", "<leader>wj", "<c-w>10+<cr>", { desc = "Increase Height" })
map("n", "<leader>wk", "<c-w>10-<cr>", { desc = "Decrease Width" })
map("n", "<leader>wl", "<c-w>10><cr>", { desc = "Increase Height" })
map("n", "<leader>wo", "<cmd>wincmd o<cr>", { desc = "Equality height and width" })
-- Movement
map("n", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Goto Left Window" })
map("n", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Goto Right Window" })
map("n", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Goto Bottom Window" })
map("n", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Goto Top Window" })
map("i", "<c-h>", "<c-o><cmd>wincmd h<cr>", { desc = "Goto Left Window" })
map("i", "<c-l>", "<c-o><cmd>wincmd l<cr>", { desc = "Goto Right Window" })
map("i", "<c-j>", "<c-o><cmd>wincmd j<cr>", { desc = "Goto Bottom Window" })
map("i", "<c-k>", "<c-o><cmd>wincmd k<cr>", { desc = "Goto Top Window" })

require("key-menu").set("n", "<leader>l", { desc = "LSP" })
map("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Show Server Info" })
map("n", "<leader>ls", "<cmd>LspInstallInfo<cr>", { desc = "Manage Servers" })

-- Debug
require("key-menu").set("n", "<leader>d", { desc = "Debug" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Run | Countine" })
map("n", "<leader>de", function() require("dapui").eval(nil, {}) end, { desc = "Eval Expression" })
map("n", "<leader>df", function() require("dapui").float_element("stacks", {}) end, { desc = "Show Floating Window" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Repl" })

require("key-menu").set("n", "<leader>v", { desc = "VCS" })
map("n", "<leader>vd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff" })
map("n", "<leader>vp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Diff" })
map("n", "<leader>vv", ToggleLazygit, { desc = "LazyGit" })

-- Diagnostic
require("key-menu").set("n", "<leader>x", { desc = "Diagnostic" })
map("n", "<leader>xt", "<cmd>TodoQuickFix<cr>", { desc = "Workspace Todos" })
map("n", "<leader>xb", function() vim.diagnostic.setloclist() end, { desc = "Buffer Diagnostic" })
map("n", "<leader>xw", function() vim.diagnostic.setqflist() end, { desc = "Workspace Diagnostic" })
map("n", "<leader>xx", function() vim.diagnostic.open_float() end, { desc = "Line Diagnostic" })
map("n", "<leader>xl", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
map("n", "<leader>xh", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })

-- UI
require("key-menu").set("n", "<leader>u", { desc = "UI" })
map("n", "<leader>ud", function() require("dapui").toggle() end, { desc = "Debug Window" })
map("n", "<leader>uf", "<cmd>NvimTreeToggle<cr>", { desc = "File Explorer" })
map("s", "<leader>us", "<cmd>SymbolsOutline<cr>", { desc = "Symbol Outline" })

-- Edit
map("n", "<leader>cg", "<cmd>lua require'neogen'.generate()<cr>", { desc = "Generate Doc" })
require("key-menu").set("n", "<leader>p", { desc = "Preview" })
map("n", "<leader>pm", "<cmd>Glow<cr>", { desc = "Preview Markdow" })
map("n", "gim", "<cmd>Telescope goimpl<cr>", { desc = "Impl Golang Interface" })

-- Finder
require("key-menu").set("n", "f", { desc = "Magic Finder" })
map("n", "fw", "<cmd>Telescope<cr>", { desc = "Open Telescope Window" })
map("n", "ff", "<cmd>Telescope find_files<cr>", { desc = "File Finder" })
map("n", "fl", "<cmd>Telescope file_browser<cr>", { desc = "File Browser" })
map("n", "fg", "<cmd>Telescope live_grep_args<cr>", { desc = "Live Grep" })
map("n", "fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep Cursor String" })
map("n", "fb", "<cmd>Telescope buffers<cr>", { desc = "All Buffers" })
map("n", "fn", "<cmd>Telescope notify<cr>", { desc = "Notifications" })
map("n", "ft", "<cmd>TodoTelescope<cr>", { desc = "Todo List" })
map("n", "fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "fr", "<cmd>Telescope lsp_references<cr>", { desc = "[LSP] References" })
map("n", "fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "[LSP] Implementations" })
map("n", "fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "[LSP] Document Symbols" })
map("n", "fp", "<cmd>Telescope project display_type=full<cr>", { desc = "List Projects" })
map("n", "fe", "<cmd>Telescope packer<cr>", { desc = "List Packer Plugins" })

-- Test
require("key-menu").set("n", "t", { desc = "Test" })
map("n", "tf", function() require("neotest").run.run() end, { desc = "Test Current Function" })
map("n", "tr", function() require("neotest").run.run(vim.fn.expand("%s")) end, { desc = "Test Current File" })
map("n", "tt", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Test Project" })
map("n", "ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Test Summary Panel" })
map("n", "to", function() require("neotest").output.open({ enter = true }) end, { desc = "Open Test Output Panel" })
map("n", "tj", function() require("neotest").jump.next({ status = "failed" }) end, { desc = "Next Failed Test" })
map("n", "tk", function() require("neotest").jump.prev({ status = "failed" }) end, { desc = "Prev Failed Test" })

map("n", "<c-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
map("i", "<c-t>", "<c-o><cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
map("n", "<c-s>", "<cmd>w<cr>", { desc = "Save Current Buffer" })
map("i", "<c-s>", "<c-o><cmd>w<cr>", { desc = "Save Current Buffer" })
map("n", "<c-x>", "<cmd>lua require('bufdelete').bufdelete(0)<cr>", { desc = "Close Current Buffer" })
map("i", "<c-x>", "<c-o><cmd>lua require('bufdelete').bufdelete(0)<cr>", { desc = "Close Current Buffer" })

map("i", "jk", "<Esc>", { desc = "Escape Insert Mode" })
map("i", "<c-u>", "<c-o>u", { desc = "Undo" })
map("i", "<c-y>", "<c-o>yy", { desc = "Copy Line" })
map("i", "<c-p>", "<c-o>p", { desc = "Paste" })

map("", "<ScrollWheelUp>", "<Nop>", {})
map("", "<ScrollWheelDown>", "<Nop>", {})
map("", "<S-ScrollWheelUp>", "<Nop>", {})
map("", "<S-ScrollWheelDown>", "<Nop>", {})
