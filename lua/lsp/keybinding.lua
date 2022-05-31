local function setup(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- Use LSP as the handler for omnifunc.
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  -- Bind buffer keymap
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local wk = require("which-key")
  wk.register({
    name = "+LSP",
    a = {
      name = "+Code Action",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      d = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display CodeLens" },
      c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run CodeLens" },
      f = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh CodeLens" },
    },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto Type Definition" },
    -- i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementations" },
    -- r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
    k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Peek Hover" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Peek SignatureHelp" },
    -- o = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document Symbol" },
    o = { "<cmd>SymbolsOutline<cr>", "Document Symbol" },
    O = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace Symbol" },
    h = {
      name = "+Hierarchy",
      -- Type Hierarchy
      t = { "<cmd>lua vim.api.nvim_err_writeln('supertypes not supported')<cr>", "SuperTypes" },
      T = { "<cmd>lua vim.api.nvim_err_writeln('subtypes not supported')<cr>", "SubTypes" },
      -- Call Hierarchy
      i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Incoming Calls" },
      o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "Outgoing Calls" },
    },
    w = {
      name = "+Workspace",
      a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
      r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
      l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspaces" },
    },
    -- l = {
    --   name = "+CodeLens",
    --   d = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display CodeLens" },
    --   r = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run CodeLens" },
    --   f = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh CodeLens" },
    -- },
  }, {
    buffer = bufnr,
    -- prefix = "<leader>g",
    prefix = "g",
  })
end

return { setup = setup }
