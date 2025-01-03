local map = vim.api.nvim_set_keymap
local defaultOpts = { noremap = true }

-- leader key
vim.g.mapleader = ','

-- pressing <Esc> inside term will enter normal mode, pressing <C-[> will send
-- <Esc> to the terminal
map("t", "<Esc>", "<C-\\><C-n>", defaultOpts)
map("t", "<C-[>", "<Esc>", defaultOpts)

-- clipboard
map("v", "<leader>cc", '"+y<CR>', defaultOpts)
map("v", "<leader>cm", '"*y<CR>', defaultOpts)

-- "sudo" write
map(
  "n",
  "<leader>W",
  "<cmd>w ! SUDO_ASKPASS=/usr/lib/seahorse/ssh-askpass sudo -A tee % >/dev/null<CR>",
  defaultOpts
)
