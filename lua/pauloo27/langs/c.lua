return {
  treesitter = {
    ensure_installed = { "c" },
  },
  load = function(on_attach)
    require("lspconfig").clangd.setup({ on_attach = on_attach })
  end,
}
