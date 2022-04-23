local M = {}

M.setup = function()
    require("hlslens").setup({
        calm_down = true,
        nearest_only = true,
        nearest_float_when = "always",
        virt_priority = 1,
    })
    require("marks").setup({})
end

return M
