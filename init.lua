-- the "pauloo27" prefix is to avoid conflicts with other plugins
-- not because i'm a narcissist, i am just a little bit
-- and even if i was, i would be a very humble one

require('pauloo27.core.prefs')    -- general preferences
require('pauloo27.core.mappings') -- general mappings

local lang_loader = require('pauloo27.langs.loader')
local load_langs = lang_loader.load_langs
local register_langs = lang_loader.register_langs

register_langs({
  require('pauloo27.langs.lua'),       -- lua support (usefull for nvim config)
  require('pauloo27.langs.go'),        -- go support
  require('pauloo27.langs.js_and_ts'), -- js and ts support
  require('pauloo27.langs.svelte'),    -- svelte support
  require('pauloo27.langs.rust'),      -- rust support
  require('pauloo27.langs.elixir'),    -- elixir support
})

-- prepare the plugin manager (lazy.nvim)
local load_plugins = require('pauloo27.plugins.loader').load
load_plugins({
  require('pauloo27.plugins.lsp'),        -- basic lsp support
  require('pauloo27.plugins.navigation'), -- better navigation, with Telescope, Harpoon and Neo-tree
  require('pauloo27.plugins.appearence'), -- nice looking vim
})

-- load the lang just after the plugins are loaded
load_langs()
