local git_icons = {
  added = "+",
  changed = "~",
  copied = ">",
  deleted = "-",
  renamed = "»",
  unmerged = "‡",
  untracked = "?",
}

local get_telescope_file_browser_opts = function()
  local fb_actions = require("telescope._extensions.file_browser.actions")
  local Path = require("plenary.path")

  local insertModeMappings = {
    ["<A-c>"] = fb_actions.create,
    ["<S-CR>"] = fb_actions.create_from_prompt,
    ["<A-r>"] = fb_actions.rename,
    ["<A-m>"] = fb_actions.move,
    ["<A-y>"] = fb_actions.copy,
    ["<A-d>"] = fb_actions.remove,
    ["<C-o>"] = fb_actions.open,
    ["<C-g>"] = fb_actions.goto_parent_dir,
    ["<C-e>"] = fb_actions.goto_home_dir,
    ["<C-w>"] = fb_actions.goto_cwd,
    ["<C-t>"] = fb_actions.change_cwd,
    ["<C-f>"] = fb_actions.toggle_browser,
    ["<C-h>"] = fb_actions.toggle_hidden,
    ["<C-s>"] = fb_actions.toggle_all,
    ["<bs>"] = fb_actions.backspace,
    [Path.path.sep] = fb_actions.path_separator,
  }

  local normalModeMappings = {
    ["c"] = fb_actions.create,
    ["r"] = fb_actions.rename,
    ["m"] = fb_actions.move,
    ["y"] = fb_actions.copy,
    ["d"] = fb_actions.remove,
    ["o"] = fb_actions.open,
    ["g"] = fb_actions.goto_parent_dir,
    ["e"] = fb_actions.goto_home_dir,
    ["w"] = fb_actions.goto_cwd,
    ["t"] = fb_actions.change_cwd,
    ["f"] = fb_actions.toggle_browser,
    ["h"] = fb_actions.toggle_hidden,
    ["s"] = fb_actions.toggle_all,
  }

  -- copy the mappings from insert mode to normal mode
  for key, action in pairs(insertModeMappings) do
    normalModeMappings[key] = action
  end

  return {
    git_icons = git_icons,
    mappings = {
      ["i"] = insertModeMappings,
      ["n"] = normalModeMappings,
    },
  }
end

local setup_telescope = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = { "truncate" },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      color_devicons = false,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    pickers = {
      git_status = {
        git_icons = git_icons,
      },
    },
    extensions = {
      file_browser = get_telescope_file_browser_opts(),
    },
  })

  local b = require("telescope.builtin")

  vim.keymap.set("n", "<C-K>", function()
    b.find_files({
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    })
  end)

  vim.keymap.set("n", "<leader>g", b.live_grep)
  vim.keymap.set("n", "<leader>0", b.buffers)
  vim.keymap.set("n", "<leader>f", function()
    telescope.extensions.file_browser.file_browser({
      cwd = vim.fn.expand("%:p:h"),
      respect_gitignore = true,
      use_fd = true,
    })
  end)
  vim.keymap.set("n", "<leader>F", function()
    telescope.extensions.file_browser.file_browser({
      files = false,
      respect_gitignore = true,
      use_fd = true,
    })
  end)
end

return {
  -- telescope 🔭
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup_telescope,
  },

  -- file browser on telescope 📁
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
