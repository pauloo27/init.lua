return {
  ensure_install = { "gleam" },
  load = function(on_attach)
    require("lspconfig").gleam.setup({ on_attach = on_attach })
  end,
}
