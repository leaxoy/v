local M = {}

M.on_attach = function(client, bufnr)
	require("lsp_signature").on_attach()
	require("illuminate").on_attach(client)

	require("lsp/keybinding").setup(bufnr)
	require("lsp/handler").setup()
	require("lsp/capabilities").codelens(client)
	-- require("lsp/capabilities").highlight(client)
	require("lsp/capabilities").format(client)

	require("lsp/hierarchy").setup()
end

M.setup = function()
	require("lsp/completion").setup()
	local lsp = require("lspconfig")
	lsp["sumneko_lua"].setup(require("lua-dev").setup())

	local lsp_opts = {
		on_attach = M.on_attach,
		capabilities = require("lsp/capabilities").update_capabilities(),
		flags = { debounce_text_changes = 150 },
	}
	local installer = require("nvim-lsp-installer")
	installer.on_server_ready(function(server)
		local lsp_settings = {
			["gopls"] = {
				gopls = {
					-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
					-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
					-- not supported
					analyses = {
						unusedparams = true,
						unreachable = true,
						unusedwrite = true,
						fieldalignment = true,
						nilness = true,
						shadow = true,
					},
					codelenses = {
						generate = true, -- show the `go generate` lens.
						gc_details = true, --  // Show a code lens toggling the display of gc's choices.
						test = true,
						tidy = true,
						upgrade_dependency = true,
					},
					experimentalWorkspaceModule = true,
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					matcher = "Fuzzy",
					-- experimentalDiagnosticsDelay = "500ms",
					diagnosticsDelay = "500ms",
					experimentalWatchedFileDelay = "100ms",
					symbolMatcher = "fuzzy",
					["local"] = "",
					gofumpt = true, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
					buildFlags = { "-tags", "integration" },
					-- buildFlags = {"-tags", "functional"}
				},
			},

			["rust_analyzer"] = {
				rust_analyzer = {
					cargo = { allFeatures = true },
					checkOnSave = { command = "clippy" },
				},
			},
		}
		lsp_opts.settings = lsp_settings[server.name] or {}
		server:setup(lsp_opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end

return M
