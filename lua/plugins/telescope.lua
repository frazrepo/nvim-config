-----------------------------------------------------------
-- Telescope configuration file
-- Plugin: nvim-telescope
-- https://github.com/nvim-telescope/telescope.nvim
-----------------------------------------------------------

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup{
  defaults = {
      file_ignore_patterns = {"node_modules"},
      preview = false,
      mappings = {
          i = {
              ["<esc>"] = actions.close,
          },
      },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    oldfiles = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    }
  },
}

-- Load fzf-native
-- if vim.g.is_win ~= true then
--     require('telescope').load_extension('fzf')
-- end

-- telescope.load_extension("git_worktree")
require('telescope').load_extension('projects')

vim.api.nvim_set_keymap('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', "<cmd>Telescope projects<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>,', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>;', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>lua require('telescope.builtin').file_browser()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>u", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", {noremap = true, silent = true})

-- vim.api.nvim_set_keymap('n', '<C-T>', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { noremap = true })
