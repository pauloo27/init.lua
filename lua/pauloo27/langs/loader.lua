local registered_langs = {}

return {
  get_registered_langs = function()
    return registered_langs
  end,
  register_langs = function(langs)
    for _, lang in ipairs(langs) do
      if lang.load_format ~= nil then
        lang.load_format()
      end
    end

    registered_langs = langs
  end,
  load_langs = function()
    local capabilities = require('pauloo27.plugins._.cmp').capabilities

    local function on_attach(_client, _bufnr)
      -- empty for now :)
    end

    for _, lang in ipairs(registered_langs) do
      lang.load(on_attach, capabilities)
    end
  end
}
