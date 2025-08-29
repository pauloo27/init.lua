local registered_langs = {}

return {
  get_registered_langs = function()
    return registered_langs
  end,
  register_langs = function(langs)
    for _, lang in ipairs(langs) do
      if lang.pre_load ~= nil then
        lang.pre_load()
      end
    end

    registered_langs = langs
  end,
  load_langs = function()
    require("pauloo27.plugins._.cmp")
    for _, lang in ipairs(registered_langs) do
      lang.load()
    end
  end,
}
