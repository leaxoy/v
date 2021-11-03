local function setup()
	local cmp = require("cmp")

	cmp.setup({
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = require("lspkind").cmp_format({
				with_text = true,
				maxwidth = 50,
				menu = {
					buffer = "[BUF]",
					nvim_lsp = "[LSP]",
					vsnip = "[SNI]",
					nvim_lua = "[LUA]",
				},
			}),
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-5),
			["<C-f>"] = cmp.mapping.scroll_docs(5),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<cr>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			["<TAB>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "vsnip" }, -- For vsnip user.
			{ name = "buffer" },
		},
		experimental = {
			ghost_text = true,
			native_menu = true,
		},
		documentation = {
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
		},
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	})

	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		sources = { { name = "buffer" } },
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
	})
end

return { setup = setup }
