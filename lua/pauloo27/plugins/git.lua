local lazy_event = require('pauloo27.plugins.loader').lazy_event

return {
  -- git integration ⬆️
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
  },

  -- more git ⬆️
  {
    'lewis6991/gitsigns.nvim',
    event = lazy_event,
    config = function()
      require('gitsigns').setup({})
    end,
  },
}
