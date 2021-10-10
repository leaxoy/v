return {
    nm = function(lhs, rhs)
        local opts = {noremap = true, silent = true}
        vim.api.nvim_set_keymap('n', lhs, rhs, opts)
    end,
    bnm = function(bufnr)
        return function(lhs, rhs)
            local opts = {noremap = true, silent = true}
            vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
        end
    end
}
