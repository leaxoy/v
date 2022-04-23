local M = {}

M.setup = function()
    require("bufferline").setup({
        options = {
            numbers = function(opts) return string.format("[%s]", opts.ordinal) end,
            close_command = "Bdelete! %d",
            offsets = {
                {
                    filetype = require("ui/file_explorer").filetype(),
                    text = require("ui/file_explorer").title(),
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "calltree",
                    text = "Call Hierarchy",
                    highlight = "Directory",
                    text_align = "center",
                },
            },
            show_close_icon = false,
            show_buffer_close_icons = false,
            show_buffer_icons = true,
            show_tab_indicators = false,
            modified_icon = "●",
            always_show_bufferline = true,
            separator_style = "slant",
            tab_size = 16,
            left_trunc_marker = "",
            right_trunc_marker = "",
            color_icons = true,
        },
    })
end
return M
