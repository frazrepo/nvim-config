--[[

Neovim init file
Version: 0.1.1 - 2021/12/04
Maintainer: frazrepo
Website: https://github.com/frazrepo/nvim-config
Debug : nvim --startuptime vim.log

--]]

-- Requires Neovim >= 0.12 (nvim-treesitter main branch, vim.lsp.config/enable)
if vim.fn.has("nvim-0.12") == 0 then
  vim.notify("This config requires Neovim >= 0.12", vim.log.levels.ERROR)
  return
end

-- Setup and define the global FrazVim table
-- _G.FrazVim = require("config.util")
require("config.util").setup()

-- Initialisation
require('config.lazy')
