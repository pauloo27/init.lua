return function()
  local ft = vim.bo.filetype

  local ts_auto_import = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports.ts" },
        diagnostics = {},
      },
    })
  end

  local fallback_auto_import = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports" },
        diagnostics = {},
      },
    })
  end

  local auto_import_per_ft = {
    ['typescript'] = ts_auto_import,
  }

  local handler = auto_import_per_ft[ft]
  if handler ~= nil then
    handler()
  else
    fallback_auto_import()
  end
end
