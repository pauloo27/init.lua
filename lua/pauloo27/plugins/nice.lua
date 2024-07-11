local lazy_event = require("pauloo27.plugins.loader").lazy_event

return {
  -- TODO comments tracker
  {
    "pauloo27/todo-comments.nvim",
    branch = "feat/comments_only_per_ft",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        good = { "DiffAdded", "#22C55E" },
      },
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        DONE = { icon = "", color = "good", alt = { "PASSED", "FAILED" } },
      },
    },
  },

  -- vim inside of vim? no way! 🤯
  { "samjwill/nvim-unception", event = lazy_event },

  -- debugger 🐛🔍️
  { "mfussenegger/nvim-dap", event = lazy_event },
  {
    "leoluz/nvim-dap-go",
    event = lazy_event,
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },

  -- treesitter 🌳
  {
    "nvim-treesitter/nvim-treesitter",
    event = lazy_event,
    build = ":TSUpdate",
    config = function()
      local registered_langs =
        require("pauloo27.langs.loader").get_registered_langs()

      local ensure_installed =
        { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

      for _, lang in ipairs(registered_langs) do
        if lang.treesitter ~= nil then
          for _, lang_to_install in ipairs(lang.treesitter.ensure_installed) do
            table.insert(ensure_installed, lang_to_install)
          end
        end
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
