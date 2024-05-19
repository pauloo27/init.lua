local lazy_event = require('pauloo27.plugins.loader').lazy_event
local defer = require('pauloo27.plugins.loader').defer

vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi NonText guibg=NONE ctermbg=NONE')
vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')

return {
  -- icons and stuff 🕸️
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- syntax highlighting 🌈
  {
    'sheerun/vim-polyglot',
    event = lazy_event,
  },

  -- pair brackets 🧱
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = "BufEnter",
  },

  -- bottom line status bar 📊
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('pauloo27.plugins._.lualine')
    end
  },

  -- improve some UIs 💄, such as lsp rename
  {
    "stevearc/dressing.nvim",
    event = lazy_event,
    opts = {
      input = {
        insert_only = false,
      },
    },
  },
}
