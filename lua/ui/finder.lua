require("telescope").setup({
  defaults = {
    prompt_prefix = "🔍 ",
    -- layout_strategy = "horizontal",
    layout_strategy = "vertical",
    layout_config = {
      horizontal = { width = 0.7, height = 0.8, prompt_position = "bottom", preview_cutoff = 120 },
      vertical = { width = 0.8, height = 0.9, prompt_position = "bottom", preview_cutoff = 40 },
      center = { width = 0.7, height = 0.3, preview_cutoff = 10, prompt_position = "top" },
      cursor = { width = 0.8, height = 0.9, preview_cutoff = 40, },
      bottom_pane = { height = 25, prompt_position = "top", preview_cutoff = 120 },
    }
  },
  pickers = {},
  extensions = {
    file_browser = {},
    live_grep_args = {
      auto_quoting = true,
    }
  }
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("media_files")
require("telescope").load_extension("project")
require("telescope").load_extension("dap")
require("telescope").load_extension("goimpl")
require("telescope").load_extension("packer")
require("telescope").load_extension("gradle")
require("telescope").load_extension("todo-comments")
require("telescope").load_extension("notify")
