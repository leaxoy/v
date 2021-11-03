local function setup()
	local wk = require("which-key")
	wk.register({
		["<space>"] = {
			l = {
				r = { "<cmd>LspRestart<cr>", "Restart Lsp Server" },
			},
			p = {
				name = "+Preview",
				m = { "<cmd>Glow<cr>", "Markdown" },
			},
			u = {
				name = "+UI Manage",
				f = { "<cmd>NvimTreeToggle<cr>", "Open File Explorer" },
				s = { "<cmd>SymbolsOutline<cr>", "Open Symbol Outline" },
				d = { "<cmd>lua require'dapui'.toggle()<cr>", "Open Debug & Test" },
			},
			b = {
				name = "+Buffer Manage",
				["]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
				["["] = { "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer" },
				b = { "<cmd>buffers<cr>", "List All Buffer" },
				e = { "<cmd>BufferLineSortByExtension<cr>", "Sort By Extensions" },
				d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort By Directories" },
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
			t = {
				name = "+Debug & Test",
				b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				c = { "<cmd>lua require'dap'.continue()<cr>", "Debug Continue" },
				i = { "<cmd>lua require'dap'.step_into()<cr>", "Debut Step Into" },
				o = { "<cmd>lua require'dap'.step_over()<cr>", "Debut Step Over" },
				r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Open Debug Repl" },
			},
			w = {
				name = "+Window Manage",
				h = { "<cmd>wincmd h<cr>", "Goto Left Window" },
				j = { "<cmd>wincmd j<cr>", "Goto Bottom Window" },
				k = { "<cmd>wincmd k<cr>", "Goto Top Window" },
				l = { "<cmd>wincmd l<cr>", "Goto Right Window" },
				v = { "<cmd>vsplit<cr>", "Split Vertically" },
				s = { "<cmd>split<cr>", "Split Horizonally" },
			},
			x = {
				name = "+Trouble Manage",
				x = { "<cmd>TroubleToggle<cr>", "Troubles" },
				w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace Troubles" },
				d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document Troubles" },
				r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP Reference Troubles" },
				q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix Troubles" },
				l = { "<cmd>TroubleToggle loclist<cr>", "LocList Troubles" },
				t = { "<cmd>TodoQuickFix<cr>", "List Todos" },
			},
			c = {
				name = "+Change & Comment",
				g = { "<cmd>lua require'neogen'.generate()<cr>", "Gen Doc" },
			},
		},
		["<c-h>"] = { "<cmd>10h<cr>", "Jump" },
		["<c-j>"] = { "<cmd>10j<cr>", "Jump" },
		["<c-k>"] = { "<cmd>10k<cr>", "Jump" },
		["<c-l>"] = { "<cmd>10l<cr>", "Jump" },
		f = {
			name = "Magic Finder",
			ca = { "<cmd>CodeActionMenu<cr>", "Code Action Menu" },
			w = { "<cmd>Telescope<cr>", "Open Telescope Window" },
			f = { "<cmd>Telescope find_files<cr>", "Open File Finder" },
			l = { "<cmd>Telescope file_browser<cr>", "Open File Browser" },
			b = { "<cmd>Telescope buffers<cr>", "Open All Buffers" },
			t = { "<cmd>TodoTelescope<cr>", "Open Todo List" },
			a = { "<cmd>Telescope lsp_code_actions<cr>", "[LSP] Code Actions" },
			d = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "[LSP] Diagnostics" },
			r = { "<cmd>Telescope lsp_references<cr>", "[LSP] References" },
			i = { "<cmd>Telescope lsp_implementations<cr>", "[LSP] Implementations" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "[LSP] Document Symbols" },
			mt = { "<cmd>Neoformat<cr>", "Format Current Buffer" },
			p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List Projects" },
		},
		gim = {
			"<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<cr>",
			"Go Impl Interface",
		},
	})
end

return { setup = setup }
