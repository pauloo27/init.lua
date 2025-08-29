return {
  treesitter = {
    ensure_installed = { "go" },
  },
  pre_load = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config

    set_ft_config("go", {
      function()
        return require("formatter.filetypes.go").gofmt()
      end,
    })
  end,
  load = function()
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          staticcheck = true,
        },
      },
      init_options = {
        usePlaceholders = true,
      },
    })
    vim.lsp.enable("gopls")
  end,
}
