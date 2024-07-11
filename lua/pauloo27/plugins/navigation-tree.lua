local map = vim.api.nvim_set_keymap

-- neo tree (file tree)
map("n", "<C-t>", "<cmd>Neotree toggle<CR>", { noremap = true })

return {
  -- file tree 🌲
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
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
        position = "right",
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
            vim.keymap.set(
              "i",
              "<esc>",
              vim.cmd.stopinsert,
              { noremap = true, buffer = args.bufnr }
            )
          end,
        },
      },
    },
  },
}
