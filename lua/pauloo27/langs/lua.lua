return {
  pre_load = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config

    set_ft_config("lua", {
      function()
        return require("formatter.filetypes.lua").stylua()
      end,
    })
  end,
  -- treesitter parser for lua is a must for treesitter, so it's included
  -- in the treesitter config, not here
  load = function()
    vim.lsp.config("lua_ls", {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (
              vim.uv.fs_stat(path .. "/.luarc.json")
              or vim.uv.fs_stat(path .. "/.luarc.jsonc")
            )
          then
            return
          end
        end

        client.config.settings.Lua =
          vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
              path = {
                "lua/?.lua",
                "lua/?/init.lua",
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
      end,
      settings = {
        Lua = {},
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
