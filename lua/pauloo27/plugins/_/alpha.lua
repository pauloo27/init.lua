local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

local header = {
  [[ ____________________________ ]],
  [[|                            |]],
  [[|            NeoVim          |]],
  [[|____________________________|]],
  [[           \ (•◡•) /         ]],
  [[            \     /           ]],
}

local version = vim.version()
local version_line = "Version "
  .. version.major
  .. "."
  .. version.minor
  .. "."
  .. version.patch

math.randomseed(os.time())

local spaces = string.rep(" ", math.floor((#header[1] - #version_line) / 2))
table.insert(header, "")
table.insert(header, spaces .. version_line)

dashboard.section.header.val = header
dashboard.section.footer.val = fortune(100)

dashboard.section.buttons.val = {
  dashboard.button("p", "   Projects", ":Telescope projects<CR>", {}),
  dashboard.button("r", "   Recent Files", ":Telescope oldfiles<CR>", {}),
  dashboard.button("u", "   Update plugins", ":Lazy sync<CR>", {}),
}

vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
alpha.setup(dashboard.opts)
