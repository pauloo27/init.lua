local mode_abbr = function()
  return vim.api.nvim_get_mode().mode
end

local full_file_name = function()
  return vim.fn.expand("%")
end

local get_color = function(name, type, fallback)
  local hl_info = vim.api.nvim_get_hl(0, {
    name = name,
  })

  if hl_info == nil then
    return fallback
  end

  local color = hl_info[type]

  if color then
    return string.format("#%06x", color)
  else
    return fallback
  end
end
local colors = {
  bg_main = get_color("StatusLine", "bg", "#ff0000"),
  fg_main = get_color("Normal", "fg", "#ff0000"),
  fg_alt = get_color("StatusLine", "fg", "#ff0000"),
}

local mode_colors = {
  a = { bg = colors.bg_main, fg = colors.fg_main, gui = "bold" },
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
    colored = false,
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
