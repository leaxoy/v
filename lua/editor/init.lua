local M = {}
M.setup = function()
    require("editor/edit").setup()
    require("editor/search").setup()
    require("editor/syntax").setup()
    require("editor/ts").setup()
end
return M
