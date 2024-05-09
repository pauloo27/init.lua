local map = vim.api.nvim_set_keymap
local defaultOpts = { noremap = true }

-- neo tree (file tree)
map('n', '<C-t>', '<cmd>Neotree focus<CR>', defaultOpts)
map('n', 'T', '<cmd>Neotree toggle<CR>', defaultOpts)

local setup_harpoon = function()
  local harpoon = require("harpoon")

  -- TODO: refact to use map()
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

  map('n', '<C-K>', "<cmd>lua require('telescope.builtin').find_files()<CR>", defaultOpts)
  map('n', '<leader>g', "<cmd>lua require('telescope.builtin').live_grep()<CR>", defaultOpts)
  map('n', '<leader>vc', "<cmd>lua require('telescope.builtin').find_files({search_dirs={'~/.config/nvim'}})<CR>",
    defaultOpts)
  map('n', '<leader>1', "<cmd>:bprevious<CR>", defaultOpts)
  map('n', '<leader>2', "<cmd>:bnext<CR>", defaultOpts)
  map('n', '<leader>0', "<cmd>lua require('telescope.builtin').buffers()<CR>", defaultOpts)
  map('n', '<leader>p', "<cmd>Telescope projects<CR>", defaultOpts)
end

return {
  -- harpoon 🔖
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
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

  -- file tree 🌲
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
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
            vim.cmd("stopinsert")
            vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
          end,
        }
      },
    }
  },
}
