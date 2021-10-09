local function setup() 
    require('which-key').setup {}
    require('toggleterm').setup {
        open_mapping = [[<C-t>]],
        hide_numbers = true,
        direction = 'float',
        shade_terminals = true,
        float_opts = {
            border = 'shadow'
        },
    }
end

return {setup = setup}

