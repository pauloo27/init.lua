local lazy_event = require("pauloo27.plugins.loader").lazy_event
local defer = require("pauloo27.plugins.loader").defer

local apply_theme = function()
  -- "visual warning" that you are using root
  if os.getenv("USER") == "root" then
    vim.cmd("colorscheme darkblue")
  else
    vim.cmd("colorscheme rose-pine-moon")
  end

  -- transparent background
  vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
  vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
  vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
end

defer(apply_theme)

return {
  -- rose pine theme 🌹
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
  },

  -- icons and stuff 🕸️
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- syntax highlighting 🌈
  {
    "sheerun/vim-polyglot",
    event = lazy_event,
  },

  -- bottom line status bar 📊
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = lazy_event,
    config = function()
      require("pauloo27.plugins._.lualine")
    end,
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
