local map = vim.api.nvim_set_keymap
local defaultOpts = { noremap = true }
local lazy_event = require('pauloo27.plugins.loader').lazy_event

-- neo tree (file tree)
map('n', '<C-t>', '<cmd>Neotree toggle<CR>', defaultOpts)
vim.keymap.set("n", "T", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

map('n', '<leader>1', "<cmd>:bprevious<CR>", defaultOpts)
map('n', '<leader>2', "<cmd>:bnext<CR>", defaultOpts)


local setup_harpoon = function()
  local harpoon = require("harpoon")

  vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
  vim.keymap.set("n", "<leader>r", function() harpoon:list():remove() end)
  vim.keymap.set("n", "<leader>R", function() harpoon:list():clear() end)

  vim.keymap.set("n", "<C-s>", function() harpoon:list():select(1) end)
  vim.keymap.set("n", "<C-f>", function() harpoon:list():select(2) end)
  vim.keymap.set("n", "<C-h>", function() harpoon:list():select(3) end)
  vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

  -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
  vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

  -- basic telescope configuration
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
  end

  vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
end

local setup_telescope = function()
  require('telescope').setup({
    defaults = {
      path_display = { "truncate" },
      file_sorter = require 'telescope.sorters'.get_fuzzy_file,
      generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    }
  })

  local b = require('telescope.builtin')

  vim.keymap.set('n', '<C-K>',
    function() b.find_files({ hidden = true, find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' } }) end)
  vim.keymap.set('n', '<leader>g', b.live_grep)
  vim.keymap.set('n', '<leader>0', b.buffers)
end

return {
  -- harpoon 🔖
  {
    "ThePrimeagen/harpoon",
    event = lazy_event,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup_harpoon,
  },

  -- telescope 🔭
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = setup_telescope,
  },

  -- file browser on telescope 📁
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  -- file tree 🌲
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = 'Neotree',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        position = 'right',
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      -- enable mode editing
      event_handlers = {
        {
          event = "neo_tree_popup_input_ready",
          handler = function(args)
            vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
          end,
        }
      },
    }
  },
}
