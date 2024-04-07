local defer = require('pauloo27.plugins.loader').defer

local apply_theme = function()
  -- visual warning that you are using root
  if os.getenv("USER") ~= 'root'
  then
    vim.cmd("colorscheme catppuccin")
  else
    vim.cmd("colorscheme darkblue")
  end

  -- transparent background
  vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  vim.cmd('hi NonText guibg=NONE ctermbg=NONE')
  vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')
end

defer(apply_theme)

return {
  -- catppuccin theme 😸
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
  },

  -- icons and stuff 🕸️
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- syntax highlighting 🌈
  {
    'sheerun/vim-polyglot',
    event = 'VeryLazy',
  },

  -- pair brackets 🧱
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = "BufEnter",
  },

  -- dashboard (start screen) 🏁
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('pauloo27.plugins._.alpha')
    end
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
    event = "VeryLazy",
    opts = {
      input = {
        insert_only = false,
      },
    },
  },

  -- better prompts 📝
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

}
