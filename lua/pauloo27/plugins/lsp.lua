local map = vim.api.nvim_set_keymap
local silentOps = { noremap = true, silent = true }
local defer = require('pauloo27.plugins.loader').defer

map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silentOps)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', silentOps)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', silentOps)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', silentOps)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silentOps)
map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', silentOps)
map('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', silentOps)
map('n', '<leader>f', "<cmd>lua require('extend.format').format()<CR>", silentOps)
map('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', silentOps)
map('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', silentOps)

return {
  { 'neovim/nvim-lspconfig',    event = 'VeryLazy' },
  { 'hrsh7th/nvim-cmp',         event = 'VeryLazy' },
  { 'hrsh7th/cmp-nvim-lsp',     event = 'VeryLazy' },
  { "L3MON4D3/LuaSnip",         event = 'VeryLazy' },
  { 'saadparwaiz1/cmp_luasnip', event = 'VeryLazy' },
  -- format ✨
  {
    'mhartington/formatter.nvim',
    event = 'VeryLazy',
    config = function()
      local format = require('pauloo27.plugins._.format')

      require('formatter').setup({
        filetype = format.ft_config,
      })

      vim.cmd("autocmd BufWritePost * lua require('pauloo27.plugins._.format').format({}, true)")
    end
  },
  -- lsp errors listing 📜
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
}
