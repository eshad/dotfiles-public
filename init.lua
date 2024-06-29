-- Enable loader if available
if vim.loader then
  vim.loader.enable()
end

-- Debug function
_G.dd = function(...)
  require("util.debug").dump(...)
end
vim.print = _G.dd



-- Your custom configurations
require("config.lazy")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



