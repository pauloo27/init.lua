return {
  treesitter = {
    ensure_installed = { "rust" },
  },
  load = function(on_attach)
    require("lspconfig").rust_analyzer.setup({
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })
  end,
}
