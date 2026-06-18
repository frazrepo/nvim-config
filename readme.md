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
* Copy the directory content to `$HOME/AppData/Local/nvim/`

# Features
* Color schemes with [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) and [catppuccin/nvim](https://github.com/catppuccin/nvim)
* File navigation with [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) and [snacks.nvim](https://github.com/folke/snacks.nvim)
* Tabs, buffers, and git status with [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) and [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* Treesitter-based syntax, text objects, autotags, and commentstring support
* LSP and completion with `nvim-lspconfig`, `mason.nvim`, and `blink.cmp`
* Formatting and linting with `conform.nvim` and `nvim-lint`
* Search and replace with `snacks.nvim`, `vim-grepper`, and `grug-far.nvim`
* Motion and editing helpers with `flash.nvim`, `mini.*`, and `nvim-surround`
* CSV viewing, quickfix filtering, todo navigation, scratch buffers, and Zen mode
