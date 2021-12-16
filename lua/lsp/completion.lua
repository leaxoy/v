local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local function setup()
	local cmp = require("cmp")

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noselect",
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		experimental = { ghost_text = true, native_menu = false },
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("lspkind").cmp_format({
				with_text = false,
				maxwidth = 50,
				menu = {
					copilot = "[AI]",
					buffer = "[BUF]",
					nvim_lsp = "[LSP]",
					vsnip = "[SNI]",
					nvim_lua = "[LUA]",
				},
			}),
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-5),
			["<C-f>"] = cmp.mapping.scroll_docs(5),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.fn["vsnip#available"](1) == 1 then
					feedkey("<Plug>(vsnip-expand-or-jump)", "")
				elseif has_words_before() then
					cmp.complete()
				else
					fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.fn["vsnip#jumpable"](-1) == 1 then
					feedkey("<Plug>(vsnip-jump-prev)", "")
				end
			end, { "i", "s" }),
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
			end,
		},
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "copilot" },
			{ name = "vsnip" }, -- For vsnip user.
			{ name = "buffer" },
			{ name = "cmdline" },
			{ name = "nvim_lua" },
			{ name = "crates" },
			{ name = "orgmode" },
			{ name = "nvim_lsp_document_symbol" },
		},
	})

	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		sources = { { name = "buffer" }, { name = "nvim_lsp_document_symbol" } },
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
	})
end

return { setup = setup }
