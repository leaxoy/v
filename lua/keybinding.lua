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
            ["]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
            ["["] = { "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer" },
            b = { "<cmd>buffers<cr>", "List All Buffer" },
            x = { "<cmd>lua require('bufdelete').bufdelete(0)<cr>", "Close Current Buffer" },
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
            f = { "<cmd>Telescope find_files<cr>", "Open File Finder" },
            l = { "<cmd>Telescope file_browser<cr>", "Open File Browser" },
            g = { "<cmd>Telescope live_grep<cr>", "Open Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Open All Buffers" },
            t = { "<cmd>TodoTelescope<cr>", "Open Todo List" },
            a = { "<cmd>Telescope lsp_code_actions<cr>", "[LSP] Code Actions" },
            d = { "<cmd>Telescope diagnostics<cr>", "[LSP] Diagnostics" },
            r = { "<cmd>Telescope lsp_references<cr>", "[LSP] References" },
            i = { "<cmd>Telescope lsp_implementations<cr>", "[LSP] Implementations" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "[LSP] Document Symbols" },
            p = { "<cmd>Telescope project display_type=full<cr>", "List Projects" },
        },
        l = {
            name = "+LSP",
            r = { "<cmd>LspRestart<cr>", "Restart Server" },
            i = { "<cmd>LspInfo<cr>", "Show Info" },
            s = { "<cmd>LspInstallInfo<cr>", "Manage Servers" },
        },
        p = {
            name = "+Preview",
            m = { "<cmd>Glow<cr>", "Markdown" },
        },
        s = {
            name = "+Session",
            s = { "<cmd>Telescope session-lens search_session<cr>", "Search" },
            a = { "<cmd>SaveSession<cr>", "Save" },
            d = { "<cmd>DeleteSession<cr>", "Delete" },
            r = { "<cmd>RestoreSession<cr>", "Restore" },
        },
        v = {
            name = "+VCS",
            p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview diff" },
            d = { "<cmd>Gitsigns diffthis<cr>", "Diff this file" },
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
            g = { "<cmd>lua ToggleLazygit()<cr>", "LazyGit" },
            s = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" },
        },
        w = {
            name = "+Window",
            c = { "<cmd>wincmd c<cr>", "Close Current Window" },
            o = { "<cmd>wincmd o<cr>", "Close Other Window" },
            h = { "<cmd>wincmd h<cr>", "Goto Left Window" },
            j = { "<cmd>wincmd j<cr>", "Goto Bottom Window" },
            k = { "<cmd>wincmd k<cr>", "Goto Top Window" },
            l = { "<cmd>wincmd l<cr>", "Goto Right Window" },
            v = { "<cmd>vsplit<cr>", "Split Vertically" },
            s = { "<cmd>split<cr>", "Split Horizonally" },
            r = {
                name = "+Resize",
                h = { "<c-w>10<", "Decrease width" },
                j = { "<c-w>10+", "Increase height" },
                k = { "<c-w>10-", "Decrease height" },
                l = { "<c-w>10>", "Increase width" },
            },
            ["="] = { "<c-w>=", "Equally high and wide" },
        },
        x = {
            name = "+Diagnostic",
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Troubles" },
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Troubles" },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP Reference Troubles" },
            q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
            l = { "<cmd>TroubleToggle loclist<cr>", "LocList Troubles" },
            t = { "<cmd>TodoQuickFix<cr>", "List Todos" },
            c = { "<cmd>lua vim.diagnostic.open_float(nil, {scope='cursor', show_header=false, focus=false, border='rounded'})<cr>", "Show Line Diagnostic" },
            x = { "<cmd>lua vim.diagnostic.open_float(nil, {scope='line', show_header=false, focus=false, border='rounded'})<cr>", "Show Line Diagnostic" },
            j = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
            k = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
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
        ["<tab>"] = { ">>", "Indent right" },
        ["<s-tab>"] = { "<<", "Indent left" },
        ["<c-s>"] = { "<cmd>w<cr>", "Save buffer" },
    }, { mode = "n" })
    wk.register({
        ["<c-h>"] = { "<c-o>^", "Start of line" },
        ["<c-l>"] = { "<c-o>$", "End of line" },
        ["<c-j>"] = { "<c-o>10j", "Jump 10 Line Down" },
        ["<c-k>"] = { "<c-o>10k", "Jump 10 Line Up" },
        ["<c-t>"] = { "<c-o><cmd>ToggleTerm<cr>", "Toggle Terminal" },
        ["<c-u>"] = { "<c-o>u", "Undo" },
        ["<c-y>"] = { "<c-o>yy", "Copy Line" },
        ["<c-p>"] = { "<c-o>p", "Paste" },
        ["jk"] = { "<Esc>", "Escape Insert Mode" },
        ["<c-s>"] = { "<c-o><cmd>w<cr>", "Save buffer" },
    }, {
        mode = "i",
    })
    wk.register({
        ["<tab>"] = { ">", "Indent right" },
        ["<s-tab>"] = { "<", "Indent left" },
        r = {
            name = "+Refactor",
            f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract Function" },
            i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline Variable" },
            r = { "<cmd>Telescope refactoring refactors<cr>", "Refactor Window" },
            v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract Variable" },
        },
    }, { mode = "v" })
end

return { setup = setup }
