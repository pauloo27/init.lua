return {
  load_format = function()
    local set_ft_config = require('pauloo27.plugins._.format').set_ft_config

    local lazy_prettier = function()
      return require('formatter.filetypes.typescript').prettierd
    end

    set_ft_config('svelte', {
      lazy_prettier,
    })
  end,
  load = function(on_attach)
    require('lspconfig').svelte.setup({ on_attach = on_attach })
  end
}
