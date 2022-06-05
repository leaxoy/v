local tree_cb = require("nvim-tree.config").nvim_tree_callback

local M = {}

M.setup_nvim_tree = function()
  require("nvim-tree").setup({
    diagnostics = { enable = true },
    disable_netrw = true,
    hijack_cursor = true,
    open_on_setup = true,
    create_in_closed_folder = false,
    respect_buf_cwd = false,
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
      hide_root_folder = true,
      -- width of the window, can be either a number (columns) or a string in `%`
      width = 30,
      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      side = "left",
      -- if true the tree will resize itself after opening a file
      -- auto_resize = true,
      -- lsp_diagnostics = true,
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
      add_trailing = false,
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "none",
      root_folder_modifier = ":~",
      indent_markers = {
        enable = true,
      },
    },
    git = { enable = true, timeout = 20 },
    actions = {
      change_dir = { enable = false },
      open_file = { resize_window = true },
    }
  })
end

return M
