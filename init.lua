--[[

Neovim init file
Version: 0.1.1 - 2021/12/04
Maintainer: frazrepo
Website: https://github.com/frazrepo/nvim-config
Debug : nvim --startuptime vim.log

--]]

-- Global variable
_G.FrazVim = require("config.util")

-- Initialisation
require('config.lazy')
