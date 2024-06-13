local lazy_event = require('pauloo27.plugins.loader').lazy_event

return {
  -- TODO comments tracker
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  -- vim inside of vim? no way! 🤯
  { 'samjwill/nvim-unception', event = lazy_event },
  -- treesitter 🌳
  {
    "nvim-treesitter/nvim-treesitter",
    event = lazy_event,
    build = ":TSUpdate",
    config = function()
      local registered_langs = require('pauloo27.langs.loader').get_registered_langs()

      local ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

      for _, lang in ipairs(registered_langs) do
        if lang.treesitter ~= nil then
          for _, lang_to_install in ipairs(lang.treesitter.ensure_installed) do
            table.insert(ensure_installed, lang_to_install)
          end
        end
      end

      require('nvim-treesitter.configs').setup({
        ensure_installed = ensure_installed,
        highlight = {
          enable = true,
        }
      })
    end
  },
}
