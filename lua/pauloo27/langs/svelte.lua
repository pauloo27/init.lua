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
    require("lspconfig").svelte.setup({
      on_attach = function(client)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
        on_attach(client)
      end,
    })
  end,
}
