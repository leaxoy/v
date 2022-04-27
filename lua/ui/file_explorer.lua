local tree_cb = require("nvim-tree.config").nvim_tree_callback

local M = {}

M.title = function()
  return "File Explorer"
end

M.filetype = function()
  return "NvimTree"
end

M.setup = function()
  require("nvim-tree").setup({
    diagnostics = { enable = true },
    -- hijack_cursor = true,
    filters = {
      custom = {
        ".DS_Store",
        ".git",
        ".idea",
        "output",
        "__pycache__",
        "*.pyc",
        ".vscode",
      },
    },
    view = {
      -- width of the window, can be either a number (columns) or a string in `%`
      width = 30,
      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      side = "left",
      -- if true the tree will resize itself after opening a file
      auto_resize = true,
      lsp_diagnostics = true,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {
          { key = "<C-[>", cb = tree_cb("dir_up") },
          { key = "<C-]>", cb = tree_cb("cd") },
          { key = "<Tab>", cb = tree_cb("preview") },
          { key = "r", cb = tree_cb("rename") },
          { key = "d", cb = tree_cb("remove") },
          { key = "a", cb = tree_cb("create") },
          { key = "f", cb = tree_cb("refresh") },
        },
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
    actions = { open_file = { resize_window = true } }
  })
end

return M
