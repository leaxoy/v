function OrganizeImports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate({ context = { context, "t", true } })

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

function GoSwitch(bang, cmd)
  local file = vim.fn.expand("%")
  local root = ""
  local alt_file = ""
  if #file <= 1 then
    vim.notify("no buffer name", vim.lsp.log_levels.ERROR)
    return
  end
  local s, e = string.find(file, "_test%.go$")
  local s2, e2 = string.find(file, "%.go$")
  if s ~= nil then
    root = vim.fn.split(file, "_test.go")[1]
    alt_file = root .. ".go"
  elseif s2 ~= nil then
    root = vim.fn.split(file, ".go")[1]
    alt_file = root .. "_test.go"
  else
    vim.notify("not a go file", vim.lsp.log_levels.ERROR)
  end
  if not vim.fn.filereadable(alt_file) and not vim.fn.bufexists(alt_file) and not bang then
    vim.notify("couldn't find " .. alt_file, vim.lsp.log_levels.ERROR)
    return
  elseif #cmd <= 1 then
    local ocmd = "e " .. alt_file
    vim.cmd(ocmd)
  else
    local ocmd = cmd .. " " .. alt_file
    vim.cmd(ocmd)
  end
end

-- parse the lines from result to get a list of the desirable output
-- Example:
-- // Recursive expansion of the eprintln macro
-- // ============================================

-- {
--   $crate::io::_eprint(std::fmt::Arguments::new_v1(&[], &[std::fmt::ArgumentV1::new(&(err),std::fmt::Display::fmt),]));
-- }
local function parse_lines(t)
  local ret = {}

  local name = t.name
  local text = "// Recursive expansion of the " .. name .. " macro"
  table.insert(ret, "// " .. string.rep("=", string.len(text) - 3))
  table.insert(ret, text)
  table.insert(ret, "// " .. string.rep("=", string.len(text) - 3))
  table.insert(ret, "")

  local expansion = t.expansion
  for string in string.gmatch(expansion, "([^\n]+)") do
    table.insert(ret, string)
  end

  return ret
end

local function rust_expand_macro(direction)
  vim.lsp.buf_request(0, "rust-analyzer/expandMacro", vim.lsp.util.make_position_params(), function(_, result)
    local latest_buf_id = nil
    -- echo a message when result is nil (meaning no macro under cursor) and
    -- exit
    if result == nil then
      vim.api.nvim_out_write("No macro under cursor!\n")
      return
    end

    -- check if a buffer with the latest id is already open, if it is then
    -- delete it and continue
    if latest_buf_id ~= nil then
      vim.api.nvim_buf_delete(latest_buf_id, { force = true })
    end

    -- create a new buffer
    latest_buf_id = vim.api.nvim_create_buf(false, true) -- not listed and scratch

    -- split the window to create a new buffer and set it to our window
    vim.cmd(direction or "vsplit")
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), latest_buf_id)

    -- set filetpe to rust for syntax highlighting
    vim.api.nvim_buf_set_option(latest_buf_id, "filetype", "rust")
    -- write the expansion content to the buffer
    vim.api.nvim_buf_set_lines(latest_buf_id, 0, 0, false, parse_lines(result))

    -- make the new buffer smaller
    -- utils.resize(true, "-25")
  end)
end

return {
  default = {
    OrganizeImports = {
      function() OrganizeImports(1000) end,
      description = "Organize imports",
    }
  },
  ["rust_analyzer"] = {
    RustExpandMacro = {
      function()
        rust_expand_macro("vsplit")
      end,
      description = "Expand Rust Macro",
    },
  },
  ["gopls"] = {
    GoSwitchTest = {
      function()
        GoSwitch("bang" == "!", "vsplit")
      end,
      description = "Switch Between Go Test & Normal File",
    },
  },
}
