local util = require("vim.lsp.util")

local select_best_client = function(on_choice)
  local method = "textDocument/formatting"
  local clients = vim.tbl_values(vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    method = method,
  }))
  -- better UX when choices are always in the same order (between restarts)
  table.sort(clients, function(a, b)
    return a.name < b.name
  end)

  if #clients < 1 then
    on_choice(nil)
  else
    on_choice(clients[1])
  end
end

local M = {
  disable_formatting = false,
}

vim.api.nvim_create_user_command("ToggleFormatting", function()
  M.disable_formatting = not M.disable_formatting
end, {})

M.ft_config = {}

M.formatter_filter = {}

M.set_ft_config = function(ft, opts, filter)
  M.ft_config[ft] = opts
  if filter ~= nil then
    M.formatter_filter[ft] = filter
  end
end

M.should_use_formatter = function(ft, bufnr)
  if M.formatter_filter[ft] then
    return M.formatter_filter[ft](ft, bufnr)
  end

  return M.ft_config[ft] ~= nil
end

M.format = function(options, write)
  if M.disable_formatting then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo.filetype

  -- try to use formatter.nvim
  if M.should_use_formatter(ft, bufnr) then
    if write then
      vim.cmd("FormatWrite")
    else
      vim.cmd("Format")
    end

    return
  end

  local params = util.make_formatting_params(options)

  -- fallback to lsp client formatting
  select_best_client(function(client)
    if client == nil then
      return
    end

    return client.request("textDocument/formatting", params, nil, bufnr)
  end)
end

return M
