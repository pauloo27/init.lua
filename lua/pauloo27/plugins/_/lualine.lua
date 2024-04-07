local modeAbbr = function()
  return vim.api.nvim_get_mode().mode
end

local fullFileName = function()
  return vim.fn.expand('%')
end

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { modeAbbr },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { fullFileName },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})
