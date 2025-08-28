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
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                --icon.highlight = hl or icon.highlight
              end
            end
          end,
          highlight = "",
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
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("setlocal relativenumber")
          end,
        },
      },
    },
  },
}
