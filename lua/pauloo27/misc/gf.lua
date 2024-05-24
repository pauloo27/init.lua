-- "Go tO File" under cursor in other window
-- credits: https://github.com/ELLIOTTCABLE/vim-gfriend
local gof = function(theremotion, heremotion)
  heremotion = heremotion or "e"
  local cword = vim.fn.expand("<cWORD>")
  local st = string.find(cword, "\v\f+:%d+")
  local en = string.match(cword, "\v\f+:%d+")
  if en then
    cword = string.sub(cword, st, en - 1)
  end
  local bits = vim.split(cword, ":")

  local starting_window = vim.api.nvim_get_current_win()

  vim.cmd("wincmd p")
  if vim.api.nvim_get_current_win() == starting_window then
    vim.cmd(theremotion .. " " .. bits[1])
  else
    vim.cmd(heremotion .. " " .. bits[1])
  end

  if #bits >= 2 then
    vim.cmd(bits[2])
  end
end

vim.keymap.set("n", "gof", gof)
vim.keymap.set("v", "gof", gof)

return {}
