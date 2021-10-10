local function setup()
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
    vim.o.termguicolors = true
    vim.o.cursorline = true
    vim.o.completeopt = "menuone,noselect"
    vim.o.autoindent = true
    vim.o.showmatch = true

    -- nvim tree config
    vim.g.nvim_tree_ignore = {
        ".DS_Store", ".git", ".idea", "output", "__pycache__", "*.pyc",
        ".vscode"
    }
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_add_trailing = 1
    vim.g.nvim_tree_group_empty = 1
end

return {setup = setup}
