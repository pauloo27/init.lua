local map = vim.api.nvim_set_keymap

-- go to previous & next buffer
map("n", "<leader>1", "<cmd>:bprevious<CR>", { noremap = true })
map("n", "<leader>2", "<cmd>:bnext<CR>", { noremap = true })

local file_tree = require("pauloo27.plugins.navigation-tree")
local telescope = require("pauloo27.plugins.navigation-telescope")

return {
  -- telescope 🔭
  telescope,
  -- file tree 🌲
  file_tree,
}
