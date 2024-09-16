return {
  load = function(on_attach)
    require("lspconfig").nil_ls.setup({ on_attach = on_attach })
  end,
}
