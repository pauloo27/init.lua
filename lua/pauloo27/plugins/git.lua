return {
  -- git integration ⬆️
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
  },

  -- more git ⬆️
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitsigns').setup({})
    end,
  },
}
