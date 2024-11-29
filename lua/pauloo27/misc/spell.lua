local complete_fn = function()
  return { "pt_br", "en_us", "no" }
end

local oneOrZeroArgs = "?"

local helpMessage = [[
enable with :Spell [language]
disable with :Spell no

some of the default binds are
]s [s to navigate between spelling errors
z= to see suggestions
zg to add word to dictionary
zw to remove word from dictionary
]]

vim.api.nvim_create_user_command("Spell", function(opts)
  local lang = opts.fargs[1]

  if lang == nil then
    print(helpMessage)
    return
  end

  if lang == "no" then
    vim.opt.spell = false
    return
  end

  vim.opt.spell = true
  vim.opt.spelllang = lang
end, { nargs = oneOrZeroArgs, complete = complete_fn })
