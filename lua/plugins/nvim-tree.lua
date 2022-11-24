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

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- require('nvim-tree').setup {
--     open_on_setup = false,
--     view = {
--         width = 32,
--         auto_resize = true
--     },
--     filters = {
--         dotfiles = true,
--         custom = { '.git', 'node_modules', '.cache', '.bin' },
--     },
-- }


-- nvim-tree mappings
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true  }
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
-- map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file
