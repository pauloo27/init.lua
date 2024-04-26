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
        or has_file_in_root('.prettierrc.js')
        or has_file_in_root('.prettierrc.json') then
      return require('formatter.filetypes.' .. lang).prettierd()
    end

    return nil
  end
end

return {
  load_format = function()
    local set_ft_config = require('pauloo27.plugins._.format').set_ft_config
    set_ft_config('javascript', {
      w_eslint_d('javascript'),
      w_prettierd('javascript'),
    })

    set_ft_config('typescript', {
      w_eslint_d('typescript'),
      w_prettierd('typescript'),
    })

    -- eww jsx, i think i am going to ... 🤢
    set_ft_config('typescriptreact', {
      w_eslint_d('typescript'),
      w_prettierd('typescript'),
    })

    set_ft_config('javascriptreact', {
      w_eslint_d('typescript'),
      w_prettierd('typescript'),
    })
  end,
  load = function(on_attach)
    require('lspconfig').tsserver.setup({ on_attach = on_attach })
  end
}
