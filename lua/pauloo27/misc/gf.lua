-- "Go tO File" under cursor in other window
-- credits: https://github.com/ELLIOTTCABLE/vim-gfriend
local gof = function()
  local cword = vim.fn.expand("<cWORD>")

  -- trim [] around the word
  cword = cword:gsub("^%[", ""):gsub("%]$", "")

  local st = string.find(cword, "\v\f+:%d+")
  local en = string.match(cword, "\v\f+:%d+")

  if en and st then
    cword = string.sub(cword, st, en - 1)
  end

  local starting_window = vim.api.nvim_get_current_win()
  local bits = vim.split(cword, ":")

  vim.cmd("wincmd p")
  if vim.api.nvim_get_current_win() == starting_window then
    vim.cmd("vsp " .. bits[1])
  else
    vim.cmd("e " .. bits[1])
  end

  if #bits >= 2 then
    -- handle lines "range" (eg somefile:20-27)
    local line_num = vim.split(bits[2], "-")[1]
    vim.cmd(line_num)
  end
end

vim.keymap.set("n", "gof", gof)
vim.keymap.set("v", "gof", gof)

return {}
