return {
  load_format = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config

    set_ft_config("lua", {
      function()
        return require("formatter.filetypes.lua").stylua()
      end,
    })
  end,
  -- treesitter parser for lua is a must for treesitter, so it's included
  -- in the treesitter config, not here
  load = function(on_attach)
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
