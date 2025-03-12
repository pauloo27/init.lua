local lazy_event = require("pauloo27.plugins.loader").lazy_event

return {
  {
    "leath-dub/snipe.nvim",
    event = lazy_event,
    config = function()
      local snipe = require("snipe")
      snipe.setup({
        hints = {
          -- Charaters to use for hints
          -- NOTE: make sure they don't collide with the navigation keymaps
          dictionary = "asdfghlwertyuiop",
        },
        ui = {
          position = "cursor",
          preselect_current = true,
          text_align = "file-first",
        },
        sort = "default",
      })

      vim.keymap.set("n", "<leader>ob", function()
        snipe.open_buffer_menu()
      end, { desc = "Open Snipe buffer menu" })
    end,
  },
  {
    "kungfusheep/snipe-lsp.nvim",
    event = lazy_event,
    dependencies = "leath-dub/snipe.nvim",
    opts = {
      keymap = {
        open_symbols_menu = "<leader>os",
      },
    },
  },
}
