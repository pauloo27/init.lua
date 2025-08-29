return {
  treesitter = {
    ensure_installed = { "svelte", "css", "scss" },
  },
  pre_load = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config

    set_ft_config("svelte", {
      function()
        return require("formatter.filetypes.typescript").prettierd()
      end,
    })
  end,
  load = function()
    local add_ft = require("pauloo27.langs.tailwindcss").add_ft
    add_ft("svelte")
    vim.lsp.enable("svelte")
  end,
}
