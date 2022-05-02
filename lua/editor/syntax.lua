local M = {}
M.setup = function()
  require("nvim-autopairs").setup({})
  require("bqf").setup({ auto_reload = true })
end
return M
