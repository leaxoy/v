local M = {}

M.setup = function()
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = "grey" -- "grey" or "colored"
    vim.g.gruvbox_material_current_word = "bold" -- `'grey background'`, `'bold'`, `'underline'`, `'italic'`
    vim.g.gruvbox_material_better_performance = 1

    vim.g.vscode_style = "dark"
    vim.g.vscode_transparent = 1
    vim.g.vscode_italic_comment = 1
    vim.g.vscode_disable_nvimtree_bg = true

    M.set_theme()
end

M.set_theme = function(opt)
    opt = opt or {}
    opt = vim.tbl_extend("keep", opt, { theme = vim.g.theme or "vscode" })
    if opt.theme == "gruvbox" then
        vim.cmd([[colorscheme gruvbox-material]])
    elseif opt.theme == "vscode" then
        vim.cmd([[colorscheme vscode]])
    end
end

return M
