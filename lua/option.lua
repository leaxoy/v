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
end

return {setup = setup}
