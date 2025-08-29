return {
  treesitter = {
    ensure_installed = { "java" },
  },
  load = function()
    vim.lsp.enable("jdtls")
  end,
}
