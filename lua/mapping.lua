local function setup()
    local map_opts = {noremap = true, silent = true};

    vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<cr>', map_opts)
    -- buffers
    vim.api.nvim_set_keymap('n', '<space>b]', '<cmd>BufferLineCycleNext<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b[', '<cmd>BufferLineCyclePrev<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>bb', '<cmd>buffers<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b1', '<cmd>BufferLineGoToBuffer 1<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b2', '<cmd>BufferLineGoToBuffer 2<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b3', '<cmd>BufferLineGoToBuffer 3<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b4', '<cmd>BufferLineGoToBuffer 4<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b5', '<cmd>BufferLineGoToBuffer 5<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b6', '<cmd>BufferLineGoToBuffer 6<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b7', '<cmd>BufferLineGoToBuffer 7<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b8', '<cmd>BufferLineGoToBuffer 8<cr>', map_opts)
    vim.api.nvim_set_keymap('n', '<space>b9', '<cmd>BufferLineGoToBuffer 9<cr>', map_opts)

    -- windows
    vim.api.nvim_set_keymap('n', '<space>wh', "<cmd>wincmd h<cr>", {noremap = false, silent = true})
    vim.api.nvim_set_keymap('n', '<space>wj', "<cmd>wincmd j<cr>", {noremap = false, silent = true})
    vim.api.nvim_set_keymap('n', '<space>wk', "<cmd>wincmd k<cr>", {noremap = false, silent = true})
    vim.api.nvim_set_keymap('n', '<space>wl', "<cmd>wincmd l<cr>", {noremap = false, silent = true})
    vim.api.nvim_set_keymap('n', '<space>wv', "<cmd>vsplit<cr>", {noremap = false, silent = true})
    vim.api.nvim_set_keymap('n', '<space>ws', "<cmd>split<cr>", {noremap = false, silent = true})

    vim.api.nvim_set_keymap('n', '<space>s', "<cmd>SymbolsOutline<cr>", map_opts)

    -- telescope finder
    vim.api.nvim_set_keymap('n', '<space>ff', "<cmd>Telescope find_files<cr>", map_opts)
    vim.api.nvim_set_keymap('n', '<space>fb', "<cmd>Telescope buffers<cr>", map_opts)
    vim.api.nvim_set_keymap('n', '<space>fr', "<cmd>Telescope file_browser<cr>", map_opts)
end

return {setup = setup}

