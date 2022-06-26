vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 1
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = true

vim.g.gruvbox_material_background = "hard" -- hard, medium or soft
vim.g.gruvbox_material_foreground = "material" -- material, mix or original
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_cursor = "auto"
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_menu_selection_background = "grey"
-- vim.g.gruvbox_material_sign_column_background = "grey"
vim.g.gruvbox_material_spell_foreground = "colored"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_show_eob = 0
vim.g.gruxbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_current_word = "grey background"
vim.g.gruvbox_material_disable_terminal_colors = 1
vim.g.gruvbox_material_statusline_style = "default"

vim.cmd({
  cmd = "colorscheme",
  args = { vim.g.theme or "vscode" }
})
