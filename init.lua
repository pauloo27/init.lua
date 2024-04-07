-- the "pauloo27" prefix is to avoid conflicts with other plugins
-- not because i'm a narcissist, i am just a little bit
-- and even if i was, i would be a very humble one

require('pauloo27.core.prefs')    -- general preferences
require('pauloo27.core.mappings') -- general mappings

-- prepare the plugin manager (lazy.nvim)
local load_plugins = require('pauloo27.plugins.loader').load
load_plugins({
  require('pauloo27.plugins.lsp'),        -- basic lsp support
  require('pauloo27.plugins.navigation'), -- better navigation, with Telescope, Harpoon and Neo-tree
  require('pauloo27.plugins.appearence'), -- basic lsp support
})

local load_langs = require('pauloo27.langs.loader')
load_langs({
  require('pauloo27.langs.lua'), -- lua support (usefull for nvim config)
  require('pauloo27.langs.go'),  -- go support
})
