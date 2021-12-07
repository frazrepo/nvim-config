
# Neovim lua configuration
This is my neovim configuration in lua.

# Goals
* Works on Windows, Linux and Mac OS
* Fast to load

# Installation
```
git clone --depth=1 https://github.com/frazrepo/nvim-config.git
```

**On linux/Mac OS**
* Create a symbolink link with `ln -s nvim-config $HOME/.config/nvim`


**On Windows**
* Copy the directory content to `$HOME/AppData/Local/nvim/init.vim`

# Features
* Beautiful theme with [tokyonight](https://github.com/folke/tokyonight.nvim)
* File Navigation with [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
* File fuzzy finder with [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) 
* Tabs and buffers management with [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
* Syntax highlighting with [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* LSP and Completion with [coc.nvim](https://github.com/neoclide/coc.nvim)

# Additional plugins
* Easy mappings access with which-key 
* Zen environment with TrueZen
* Quickfix filtering with nvim-bqf
* Terminal management with vim-floatterm
