return {
  treesitter = {
    ensure_installed = { "elixir" },
  },
  load = function()
    vim.lsp.config("elixirls", {
      cmd = { "/sbin/elixir-ls" },
    })
    vim.lsp.enable("elixirls")
  end,
}
