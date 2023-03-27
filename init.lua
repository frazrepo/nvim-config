--[[

Neovim init file
Version: 0.1.1 - 2021/12/04
Maintainer: fraztech
Website: https://github.com/fraztech/neovim-lua
Debug : nvim --startuptime vim.log

--]]

-----------------------------------------------------------
-- Workaround
-----------------------------------------------------------

-- Workaround for neovim#20456: vim syntax for lua files are broken in neovim 0.8+
-- As a workaround, we use treesitter based highlight for lua
if vim.fn.has('nvim-0.8') > 0 then
  -- see also: ~/.config/nvim/after/queries/lua/highlights.scm
  vim.g.ts_highlight_lua = true
end

-----------------------------------------------------------
-- LSP Provider LSP or coc
-----------------------------------------------------------
-- define lsp provider : native | coc
vim.g.lspprovider = 'native'

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('settings')
require('mappings')
require('plugins.lazy')
require('configs.extras')
require('ginit')
