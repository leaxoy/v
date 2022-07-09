local lsp_notify = function(client_name, msg, level, timeout, keep_fn)
  require("notify").notify(
    client_name .. ": " .. msg,
    level,
    {
      title = "Language Server Protocol",
      icon = "",
      timeout = timeout or 3000,
      keep = keep_fn or function() return false end,
    }
  )
end

-- cmd_fn make function that call command with args
local cmd_fn = function(cmd, args)
  return function() vim.cmd({ cmd = cmd, args = args }) end
end

return { lsp_notify = lsp_notify, cmd_fn = cmd_fn }
