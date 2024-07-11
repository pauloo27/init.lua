local group =
  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

local has_highlight_support = function()
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    method = "textDocument/documentHighlight",
  })

  return #clients > 0
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = group,
  callback = function()
    if has_highlight_support() then
      vim.lsp.buf.document_highlight()
    end
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = group,
  callback = function()
    if has_highlight_support() then
      vim.lsp.buf.clear_references()
    end
  end,
})
