local util = require('vim.lsp.util')

local select_best_client = function(on_choice)
  local method = 'textDocument/formatting'
  local clients = vim.tbl_values(vim.lsp.buf_get_clients())
  clients = vim.tbl_filter(function(client)
    return client.name == 'eslint' or client.supports_method(method)
  end, clients)
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

local M = {}

M.ft_config = {}

M.set_ft_config = function(ft, opts)
  M.ft_config[ft] = opts
end

M.format = function(options, write)
  local params = util.make_formatting_params(options)
  local bufnr = vim.api.nvim_get_current_buf()

  -- try to use formatter.nvim
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  if M.ft_config[ft] ~= nil then
    if write then
      vim.cmd('FormatWrite')
    else
      vim.cmd('Format')
    end

    return
  end

  -- fallback to lsp client formatting
  select_best_client(function(client)
    if client == nil then
      return
    end

    return client.request('textDocument/formatting', params, nil, bufnr)
  end)
end

return M;
