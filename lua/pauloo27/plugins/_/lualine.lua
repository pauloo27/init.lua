local mode_abbr = function()
  return vim.api.nvim_get_mode().mode
end

local full_file_name = function()
  return vim.fn.expand("%")
end

local colors = {
  bg_main = "#fffaf3",
  bg_alt = "#f4ede8",
  fg_main = "#9893a5",
  fg_alt = "#575279",
}

local mode_colors = {
  a = { bg = colors.bg_alt, fg = colors.fg_main, gui = "bold" },
  b = { bg = colors.bg_main, fg = colors.fg_alt },
  c = { bg = colors.bg_main, fg = colors.fg_main },
}

local theme = {
  normal = mode_colors,
  insert = mode_colors,
  visual = mode_colors,
  replace = mode_colors,
  command = mode_colors,
  inactive = mode_colors,
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = theme,
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
