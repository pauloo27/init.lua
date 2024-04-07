return {
  -- vim inside of vim? no way! 🤯
  { 'samjwill/nvim-unception', event = 'VeryLazy' },
  -- treesitter 🌳
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
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
