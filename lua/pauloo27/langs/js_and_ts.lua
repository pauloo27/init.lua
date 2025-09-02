local has_any_file_in_root = function(files)
  local file = vim.fs.find(files, {
    upward = true,
    stop = vim.fs.normalize("~"),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })

  return #file >= 1
end

local function make_formatter(formatter, lang)
  return function()
    if has_any_file_in_root(formatter.files) then
      return require("formatter.filetypes." .. lang)[formatter.name]()
    end
    return nil
  end
end

local denofmt = {
  name = "denofmt",
  files = { "deno.json", "deno.jsonc" },
}

local eslint_d = {
  name = "eslint_d",
  files = {
    ".eslintrc.json",
    ".eslintrc.js",
    "eslint.config.mjs",
    ".eslintrc.cjs",
  },
}

local prettierd = {
  name = "prettierd",
  files = {
    ".prettierrc",
    ".prettierrc.js",
    ".prettierrc.json",
  },
}

return {
  treesitter = {
    ensure_installed = { "typescript", "javascript", "jsdoc" },
  },
  pre_load = function()
    local set_ft_config = require("pauloo27.plugins._.format").set_ft_config
    local if_not_biome = function()
      return not has_any_file_in_root("biome.json")
    end

    local use_format = function(filetypes, lang, formatters)
      local opts = {}
      for _, fomatter in ipairs(formatters) do
        table.insert(opts, make_formatter(fomatter, lang))
      end

      for _, ft in ipairs(filetypes) do
        set_ft_config(ft, opts, if_not_biome)
      end
    end

    use_format(
      { "javascript", "javascriptreact" },
      "javascript",
      { prettierd, eslint_d }
    )

    use_format(
      { "typescript", "typescriptreact" },
      "typescript",
      { denofmt, prettierd, eslint_d }
    )
  end,
  load = function()
    local add_ft = require("pauloo27.langs.tailwindcss").add_ft
    add_ft({ "javascriptreact", "typescriptreact", "html" })

    local lspconfig = require("lspconfig")

    vim.lsp.config("denols", {
      root_dir = function(bufnr, on_dir)
        local project_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
        if not project_root then
          return
        end

        on_dir(project_root)
      end,
      init_options = {
        lint = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
            },
          },
        },
      },
    })

    vim.lsp.config("ts_ls", {
      root_dir = function(bufnr, on_dir)
        -- ignore deno
        local denoRootDir =
          lspconfig.util.root_pattern("deno.json", "deno.json")(bufnr)
        if denoRootDir then
          return nil
        end

        local root_markers = {
          "package-lock.json",
          "yarn.lock",
          "pnpm-lock.yaml",
          "bun.lockb",
          "bun.lock",
        }
        -- Give the root markers equal priority by wrapping them in a table
        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers }
          or root_markers
        local project_root = vim.fs.root(bufnr, root_markers)
        if not project_root then
          return
        end

        on_dir(project_root)
      end,
    })

    vim.lsp.enable("denols")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("biome")
  end,
}
