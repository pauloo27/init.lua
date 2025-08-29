return {
  treesitter = {
    ensure_installed = { "templ" },
  },
  load = function()
    vim.filetype.add({ extension = { templ = "templ" } })
    local add_ft = require("pauloo27.langs.tailwindcss").add_ft
    add_ft("templ")
    vim.lsp.enable("templ")
  end,
}
