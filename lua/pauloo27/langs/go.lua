return {
  treesitter = {
    ensure_installed = { 'go' },
  },
  load_format = function()
    local set_ft_config = require('pauloo27.plugins._.format').set_ft_config

    set_ft_config('go', {
      function() return require('formatter.filetypes.go').gofmt() end,
    })
  end,
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
