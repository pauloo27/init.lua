return {
  load = function(on_attach)
    require('lspconfig').elixirls.setup({ on_attach = on_attach, cmd = { '/sbin/elixir-ls' } })
  end
}
