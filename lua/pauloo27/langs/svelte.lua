return {
  treesitter = {
    ensure_installed = { "svelte", "css", "scss" },
  },
  load_format = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config

    set_ft_config("svelte", {
      function()
        return require("formatter.filetypes.typescript").prettierd()
      end,
    })
  end,
  load = function(on_attach)
    require("lspconfig").svelte.setup({ on_attach = on_attach })
  end,
}
