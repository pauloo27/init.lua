return {
  treesitter = {
    ensure_installed = { "c" },
  },
  load = function()
    vim.lsp.enable("clangd")
  end,
}
