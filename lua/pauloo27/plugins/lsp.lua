local map = vim.api.nvim_set_keymap
local silentOps = { noremap = true, silent = true }
local lazy_event = require('pauloo27.plugins.loader').lazy_event

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action)
vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>f', require('pauloo27.plugins._.format').format)
vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev)

return {
  { 'neovim/nvim-lspconfig',    event = lazy_event },
  { 'hrsh7th/nvim-cmp',         event = lazy_event },
  { 'hrsh7th/cmp-nvim-lsp',     event = lazy_event },
  { "L3MON4D3/LuaSnip",         event = lazy_event },
  { 'saadparwaiz1/cmp_luasnip', event = lazy_event },
  -- format ✨
  {
    'mhartington/formatter.nvim',
    event = lazy_event,
    config = function()
      local format = require('pauloo27.plugins._.format')

      require('formatter').setup({
        filetype = format.ft_config,
      })

      vim.cmd("autocmd BufWritePost * lua require('pauloo27.plugins._.format').format({}, true)")
    end
  },
}
