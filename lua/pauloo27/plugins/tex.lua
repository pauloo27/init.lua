return {
  -- latex :)
  {
    "lervag/vimtex",
    --ft = "tex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
}
