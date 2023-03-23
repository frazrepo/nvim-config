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

-- Theme update for catppucin
local base1 = "#2D3145"
local base2 = "#32364A"
local colors = require("catppuccin.palettes").get_palette()
require("catppuccin.lib.highlighter").syntax({
  TelescopePromptNormal = { fg = colors.text, bg = base1 },
  TelescopePromptBorder = { fg = base1, bg = base1 },
  TelescopePromptTitle = { fg = colors.subtext1, bg = base1 },

  TelescopeResultsNormal = { fg = colors.subtext1, bg = base1 },
  TelescopeResultsBorder = { fg = base1, bg = base1 },
  TelescopeResultsTitle = { fg = base1, bg = base1 },

  TelescopePreviewNormal = { bg = base2 },
  TelescopePreviewBorder = { fg = base2, bg = base2 },
  TelescopePreviewTitle = { fg = base2, bg = base2 },

  -- TelescopeMultiSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" }  },
  -- TelescopeSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" } },

  -- TelescopePromptNormal = { bg = colors.mantle },
  -- TelescopeResultsNormal = { bg = colors.mantle },
  -- TelescopePreviewNormal = { bg = colors.mantle },
})

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
