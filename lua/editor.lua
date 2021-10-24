local function setup()
	require("autosave").setup({
		enabled = true,
		execution_message = "AutoSave: [time]: "
			.. vim.fn.strftime("%H:%M:%S")
			.. ", [file]: "
			.. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
		events = { "InsertLeave", "TextChanged" },
		conditions = {
			exists = true,
			filename_is_not = {},
			filetype_is_not = {},
			modifiable = true,
		},
		write_all_buffers = false,
		on_off_commands = true,
		clean_command_line_interval = 0,
		debounce_delay = 200,
	})
	require("Comment").setup({
		toggler = {
			line = "<space>cc",
			block = "<space>cv",
		},
	})
	require("neogen").setup({ enabled = true })
end

return { setup = setup }
