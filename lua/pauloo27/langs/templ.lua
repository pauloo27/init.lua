return {
  treesitter = {
    ensure_installed = { "templ" },
  },
  load = function(on_attach, capabilities)
    vim.filetype.add({ extension = { templ = "templ" } })
    local add_ft = require("pauloo27.langs.tailwindcss").add_ft
    add_ft("templ")

    require("lspconfig").templ.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
