return {
  load = function(on_attach)
    require('lspconfig').lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
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
  end
}
