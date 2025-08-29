local filetypes = {}

return {
  add_ft = function(ft_to_add)
    if type(ft_to_add) == "table" then
      for _, ft in ipairs(ft_to_add) do
        table.insert(filetypes, ft)
      end
    else
      table.insert(filetypes, ft_to_add)
    end
  end,
  load = function()
    vim.lsp.config("tailwindcss", {
      filetypes = filetypes,
    })
    vim.lsp.enable("tailwindcss")
  end,
}
