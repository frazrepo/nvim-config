-----------------------------------------------------------
-- File manager configuration file
-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua
-----------------------------------------------------------

-- Keybindings are defined in `keymapping.lua`:
--- https://github.com/kyazdani42/nvim-tree.lua#keybindings

-- Note: options under the g: command should be set BEFORE running the
--- setup function:
--- https://github.com/kyazdani42/nvim-tree.lua#setup
--- See: `help NvimTree`
local g = vim.g

g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1
}

g.nvim_tree_icons = {
	default = "‣ "
}

require('nvim-tree').setup {
    open_on_setup = false,
    auto_close = true,
    view = {
        width = 32,
        auto_resize = true
    },
    filters = {
        dotfiles = true,
        custom = { '.git', 'node_modules', '.cache', '.bin' },
    },
}


-- nvim-tree mappings
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true  }
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
-- map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file