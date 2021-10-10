local function setup()
    local nm = require('utils/bind').nm

    -- ui key bind
    nm('<space>uf', '<cmd>NvimTreeToggle<cr>')
    nm('<space>us', "<cmd>SymbolsOutline<cr>")

    -- buffer key bind
    nm('<space>b]', '<cmd>BufferLineCycleNext<cr>')
    nm('<space>b[', '<cmd>BufferLineCyclePrev<cr>')
    nm('<space>bb', '<cmd>buffers<cr>')
    nm('<space>b1', '<cmd>BufferLineGoToBuffer 1<cr>')
    nm('<space>b2', '<cmd>BufferLineGoToBuffer 2<cr>')
    nm('<space>b3', '<cmd>BufferLineGoToBuffer 3<cr>')
    nm('<space>b4', '<cmd>BufferLineGoToBuffer 4<cr>')
    nm('<space>b5', '<cmd>BufferLineGoToBuffer 5<cr>')
    nm('<space>b6', '<cmd>BufferLineGoToBuffer 6<cr>')
    nm('<space>b7', '<cmd>BufferLineGoToBuffer 7<cr>')
    nm('<space>b8', '<cmd>BufferLineGoToBuffer 8<cr>')
    nm('<space>b9', '<cmd>BufferLineGoToBuffer 9<cr>')

    -- window key bind
    nm('<space>wh', "<cmd>wincmd h<cr>")
    nm('<space>wj', "<cmd>wincmd j<cr>")
    nm('<space>wk', "<cmd>wincmd k<cr>")
    nm('<space>wl', "<cmd>wincmd l<cr>")

    nm('<space>wv', "<cmd>vsplit<cr>")
    nm('<space>ws', "<cmd>split<cr>")

    -- file finder
    nm('ff', "<cmd>Telescope find_files<cr>")
    nm('fb', "<cmd>Telescope buffers<cr>")
    nm('fr', "<cmd>Telescope file_browser<cr>")
    nm('fa', "<cmd>Telescope lsp_code_actions<cr>")
    nm('fd', "<cmd>Telescope lsp_workspace_diagnostics<cr>")
    nm('fr', "<cmd>Telescope lsp_references<cr>")
    nm('fi', "<cmd>Telescope lsp_implementations<cr>")
    nm('fs', "<cmd>Telescope lsp_document_symbols<cr>")
end

return {setup = setup}
