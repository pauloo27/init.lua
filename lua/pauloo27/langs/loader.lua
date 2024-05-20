local registered_langs = {}

return {
  register_langs = function(langs)
    for _, lang in ipairs(langs) do
      if lang.load_format ~= nil then
        lang.load_format()
      end
    end

    registered_langs = langs
  end,
  load_langs = function()
    local capabilities = require('pauloo27.plugins._.cmp').capabilities

    local cursor_hold_on_attach = function(client, bufnr)
      if client.supports_method "textDocument/documentHighlight" then
        local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end


    local function on_attach(client, bufnr)
      cursor_hold_on_attach(client, bufnr)
    end

    for _, lang in ipairs(registered_langs) do
      lang.load(on_attach, capabilities)
    end
  end
}
