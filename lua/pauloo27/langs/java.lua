return {
  load = function(on_attach)
    require('lspconfig').jdtls.setup({ on_attach = on_attach })
  end
}
