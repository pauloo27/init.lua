local deferred = {}

local defer = function(fn)
  table.insert(deferred, fn)
end

local load = function(plugins)
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(plugins)

  for _, fn in ipairs(deferred) do
    fn()
  end
end

return {
  load = load,
  defer = defer,
  lazy_event = #vim.fn.argv() > 0 and "VeryLazy" or "UIEnter"
}
