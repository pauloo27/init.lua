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

local has_file_in_root = function(name)
  local file = vim.fs.find(name, {
    upward = true,
    stop = vim.fs.normalize("~"),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })

  return #file >= 1
end

local w_eslint_d = function(lang)
  return function()
    if has_file_in_root('.eslintrc.json')
        or has_file_in_root('.eslintrc.js')
        or has_file_in_root('.eslintrc.cjs') then
      return require('formatter.filetypes.' .. lang).eslint_d()
    end

    return nil
  end
end


local w_prettierd = function(lang)
  return function()
    if has_file_in_root('.prettierrc')
        or has_file_in_root('.prettierrc.json') then
      return require('formatter.filetypes.' .. lang).prettierd()
    end

    return nil
  end
end

M.ft_config = {
  go = {
    require('formatter.filetypes.go').gofmt,
  },
  javascript = {
    w_eslint_d('javascript'),
    w_prettierd('javascript'),
  },
  typescript = {
    w_eslint_d('typescript'),
    w_prettierd('typescript'),
  },
  svelte = {
    require('formatter.filetypes.typescript').prettierd,
  },

  -- eww jsx, i think i am going to ... 🤢
  typescriptreact = {
    w_eslint_d('typescript'),
    w_prettierd('typescript'),
  },
  javascriptreact = {
    w_eslint_d('typescript'),
    w_prettierd('typescript'),
  },
}

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
