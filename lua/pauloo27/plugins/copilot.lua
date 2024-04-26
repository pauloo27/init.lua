return {
  -- copilot 🤖
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        help = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      suggestion = {
        auto_trigger = false,
        keymap = {
          accept = '<C-j>',
        },
      },
    }
  },
}
