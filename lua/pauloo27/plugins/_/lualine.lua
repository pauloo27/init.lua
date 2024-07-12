local mode_abbr = function()
  return vim.api.nvim_get_mode().mode
end

local full_file_name = function()
  return vim.fn.expand("%")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { mode_abbr },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { full_file_name },
    lualine_x = { "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
