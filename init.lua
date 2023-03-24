--[[

Neovim init file
Version: 0.1.1 - 2021/12/04
Maintainer: fraztech
Website: https://github.com/fraztech/neovim-lua
Debug : nvim --startuptime vim.log

--]]

-----------------------------------------------------------
-- LSP Provider LSP or coc
-----------------------------------------------------------
-- define lsp provider
-- vim.g.lspprovider = 'native'
vim.g.lspprovider = 'coc'

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('settings')
require('mappings')
require('plugins.lazy')
require('configs.extras')
require('ginit')
