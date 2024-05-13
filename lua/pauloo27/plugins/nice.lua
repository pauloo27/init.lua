local lazy_event = require('pauloo27.plugins.loader').lazy_event

return {
  -- vim inside of vim? no way! 🤯
  { 'samjwill/nvim-unception', event = lazy_event },
  -- treesitter 🌳
  {
    "nvim-treesitter/nvim-treesitter",
    event = lazy_event,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        }
      })
    end
  },
}
