--[[

Neovim init file
Version: 0.1.1 - 2021/12/04
Maintainer: fraztech
Website: https://github.com/fraztech/neovim-lua
Debug : nvim --startuptime vim.log

--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------

require('impatient')
require('settings')
require('mappings')
require('colors')
require('plugins/packer')
require('plugins/coc')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/telescope')
require('plugins/treesitter')
require('plugins/nvim-tree')
require('plugins/whichkey')
require('lualine').setup()
