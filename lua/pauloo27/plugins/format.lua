return {
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
}
