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
if vim.g.vscode then
    require('vscodesettings')
else
    -- ordinary Neovim
    require('settings')
    require('mappings')
    require('plugins/lazy')
    require('ginit')
end
