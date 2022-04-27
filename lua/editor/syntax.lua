local M = {}
M.setup = function()
  require("nvim-autopairs").setup({})
  require("bqf").setup({})
end
return M
