return {
  load = function(on_attach, capabilities)
    require('lspconfig').gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          staticcheck = true,
        },
      },
      init_options = {
        usePlaceholders = true,
      }
    })
  end
}
