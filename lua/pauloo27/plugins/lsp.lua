local lazy_event = require("pauloo27.plugins.loader").lazy_event
local auto_import = require("pauloo27.plugins._.auto_import")

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>i", auto_import)
vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>f", require("pauloo27.plugins._.format").format)
vim.keymap.set("n", "<C-n>", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "<C-p>", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

return {
  { "neovim/nvim-lspconfig", event = lazy_event },
  { "hrsh7th/nvim-cmp", event = lazy_event },
  { "hrsh7th/cmp-nvim-lsp", event = lazy_event },
  { "L3MON4D3/LuaSnip", event = lazy_event },
  { "saadparwaiz1/cmp_luasnip", event = lazy_event },
  -- format ✨
  {
    "mhartington/formatter.nvim",
    event = lazy_event,
    config = function()
      local format = require("pauloo27.plugins._.format")

      require("formatter").setup({
        filetype = format.ft_config,
      })

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function()
          format.format({}, true)
        end,
      })
    end,
  },
}
