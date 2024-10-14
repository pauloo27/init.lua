-- enable with :Spell [lang]
-- disable with :Spell no
-- some of the default binds are
-- ]s [s to navigate between spelling errors
-- z= to see suggestions
-- zg to add word to dictionary
-- zw to remove word from dictionary
vim.api.nvim_create_user_command("Spell", function(opts)
  local lang = opts.fargs[1]

  if lang == "no" then
    vim.opt.spell = false
    return
  end

  vim.opt.spell = true
  vim.opt.spelllang = lang
end, { nargs = 1 })
