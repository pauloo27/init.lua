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

local biome = {
  name = "biome",
  files = { "biome.json" },
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

    local use_format = function(filetypes, lang, formatters)
      local opts = {}
      for _, fomatter in ipairs(formatters) do
        table.insert(opts, make_formatter(fomatter, lang))
      end

      for _, ft in ipairs(filetypes) do
        set_ft_config(ft, opts)
      end
    end

    use_format(
      { "javascript", "javascriptreact" },
      "javascript",
      { biome, prettierd, eslint_d }
    )

    use_format(
      { "typescript", "typescriptreact" },
      "typescript",
      { denofmt, biome, prettierd, eslint_d }
    )
  end,
  load = function(on_attach)
    local add_ft = require("pauloo27.langs.tailwindcss").add_ft
    add_ft({ "javascriptreact", "typescriptreact", "html" })

    local lspconfig = require("lspconfig")
    lspconfig.denols.setup({
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
      on_attach = on_attach,
    })

    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      root_dir = function(filename, bufnr)
        local denoRootDir =
          lspconfig.util.root_pattern("deno.json", "deno.json")(filename)
        if denoRootDir then
          return nil
        end

        return lspconfig.util.root_pattern("package.json")(filename)
      end,
      single_file_support = false,
    })
  end,
}
