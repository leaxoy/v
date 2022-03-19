local function setup()
	require("gitsigns").setup({
		current_line_blame = true,
	})
end

return { setup = setup }
