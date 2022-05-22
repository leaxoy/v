local log = require("vim.lsp.log")

local M = {}

local function location_handler(_, result, ctx, _)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, "No location found")
    return nil
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  -- textDocument/definition can return Location or Location[]
  -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding)

    if #result > 1 then
      vim.fn.setqflist({}, " ", {
        title = "LSP locations",
        items = vim.lsp.util.locations_to_items(result, client.offset_encoding)
      })
      vim.api.nvim_command("botright copen")
    end
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding)
  end
end

local semantic_token_refresh = function(err, params, ctx, config)
  vim.lsp.buf_request(0, "textDocument/semanticTokens/full",
    {
      textDocument = vim.lsp.util.make_text_document_params(),
      tick = vim.api.nvim_buf_get_changedtick(0)
    }, nil)
  return vim.NIL
end

local semantic_token_full = function(err, result, ctx, config)
  if err or not result or ctx.params.tick ~= vim.api.nvim_buf_get_changedtick(ctx.bufnr) then
    return
  end
  -- temporary handler until native support lands
  local bufnr = ctx.bufnr
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local legend = client.server_capabilities.semanticTokensProvider.legend
  local token_types = legend.tokenTypes
  local data = result.data

  local ns = vim.api.nvim_create_namespace("nvim-lsp-semantic")
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local prev_line, prev_start = nil, 0
  for i = 1, #data, 5 do
    local delta_line = data[i]
    prev_line = prev_line and prev_line + delta_line or delta_line
    local delta_start = data[i + 1]
    prev_start = delta_line == 0 and prev_start + delta_start or delta_start
    local token_type = token_types[data[i + 3] + 1]
    local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
    local byte_start = vim.str_byteindex(line, prev_start)
    local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
    vim.api.nvim_buf_add_highlight(bufnr, ns, "LspSemantic_" .. token_type, prev_line, byte_start, byte_end)
    -- require('vim.lsp.log').debug(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
  end
end

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
  --see: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_declaration
  ["textDocument/declaration"] = location_handler,
  --see: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
  ["textDocument/definition"] = location_handler,
  --see: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_typeDefinition
  ["textDocument/typeDefinition"] = location_handler,
  --see: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_implementation
  ["textDocument/implementation"] = location_handler,
  --see: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
  ["workspace/semanticTokens/refresh"] = semantic_token_refresh,
  ["workspace/semanticTokens/full"] = semantic_token_full,
  ["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
    require("notify")({ result.message }, lvl, {
      title = "LSP | " .. client.name,
      timeout = 10000,
      keep = function()
        return lvl == "ERROR" or lvl == "WARN"
      end,
    })
  end
}

return M
