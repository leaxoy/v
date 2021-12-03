local M = {}

M.setup = function()
	require("bufferline").setup({
		options = {
			numbers = function(opts)
				return string.format("[%s]", opts.ordinal)
			end,
			highlights = {
				fill = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				background = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				buffer_visible = {
					gui = "",
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "Normal" },
				},
				buffer_selected = {
					gui = "",
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "Normal" },
				},
				separator = {
					guifg = { attribute = "bg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				separator_selected = {
					guifg = { attribute = "fg", highlight = "Special" },
					guibg = { attribute = "bg", highlight = "Normal" },
				},
				separator_visible = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				close_button = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				close_button_selected = {
					guifg = { attribute = "fg", highlight = "normal" },
					guibg = { attribute = "bg", highlight = "normal" },
				},
				close_button_visible = {
					guifg = { attribute = "fg", highlight = "normal" },
					guibg = { attribute = "bg", highlight = "normal" },
				},
			},
			close_command = "Bdelete! %d",
			offsets = {
				{
					filetype = require("ui/file_explorer").filetype(),
					text = require("ui/file_explorer").title(),
					highlight = "Directory",
					text_align = "center",
				},
				{
					filetype = require("ui/outline").filetype(),
					text = require("ui/outline").title(),
					highlight = "Directory",
					text_align = "center",
				},
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics, ctx)
				local signs = { error = "", warning = "", hint = "", information = "" }
				return signs[level] .. "." .. count
			end,
			show_close_icon = false,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = false,
			modified_icon = "●",
			always_show_bufferline = true,
			separator_style = "slant",
			tab_size = 16,
			left_trunc_marker = "",
			right_trunc_marker = "",
		},
	})
end
return M
