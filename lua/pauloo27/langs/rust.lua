return {
  treesitter = {
    ensure_installed = { "rust" },
  },
  load = function()
    vim.lsp.config("rust_analyzer", {
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")
  end,
}
