local function setup()
    -- tree sitter
    require('nvim-treesitter.configs').setup {
        highlight = {
            enable = true,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        }
    }

    require('vcs').setup {}

    -- indent
    require("indent_blankline").setup {
        char = "|",
        buftype_exclude = {"terminal"}
    }
    
    require('nvim-autopairs').setup {}
    require('github-theme').setup {
        theme_style = 'dark',
        transparent = true,
    }

    require('nvim-tree').setup {
        view = {
            -- width of the window, can be either a number (columns) or a string in `%`
            width = 30,
            -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
            side = 'left',
            -- if true the tree will resize itself after opening a file
            auto_resize = true,
            lsp_diagnostics = true,
            mappings = {
                -- custom only false will merge the list with the default mappings
                -- if true, it will only use your list to set the mappings
                custom_only = false,
                -- list of mappings to set on the tree manually
                list = {}
            }
        }
    }

    require('bufferline').setup{
        options = {
            numbers = 'ordinal',
            indicator_icon = '▎',
            close_command = 'bdelete %d',
            offsets = {{
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }},
            show_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            separator_style = 'slant',
        }
    }

    require('lualine').setup{ 
        options = { theme = 'horizon' },
        sections = {
            lualine_x = {},
        },
    }

    require("symbols-outline").setup{
        highlight_hovered_item = true,
        show_guides = true,
        show_symbol_details = true,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {},
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "P",
            rename_symbol = "r",
            code_actions = "a",
        },
    }
end

return {setup = setup}
