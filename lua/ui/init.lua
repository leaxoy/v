local M = {}

M.setup = function()
  require("dressing").setup({
    input = { entabled = true, prompt_align = "center" },
    select = { enabled = true },
  })

  require("nvim-web-devicons").setup({ default = true })
  require("ui/file_explorer").setup_nvim_tree()
  require("ui/finder").setup()
  -- require("ui/tabline").setup()
  require("ui/terminal").setup()
  require("ui/statusline").setup()
  require("ui/theme").setup({ theme = "vscode" })
end

return M
