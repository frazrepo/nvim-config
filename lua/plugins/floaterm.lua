-----------------------------------------------------------
-- Floaterm configuration file
-----------------------------------------------------------
local M = {}

function M.setup()
    -- g.floaterm_wintype='normal'
    -- g.floaterm_height=6

    -- g.floaterm_keymap_toggle = '<Space>tt'
    -- g.floaterm_keymap_next   = '<Space>to'
    -- g.floaterm_keymap_prev   = '<Space>tp'
    -- g.floaterm_keymap_new    = '<Space>tn'
    -- g.floaterm_keymap_kill   = '<Space>tw'

    vim.g.floaterm_gitcommit='floaterm'
    vim.g.floaterm_autoinsert=1
    vim.g.floaterm_width=0.8
    vim.g.floaterm_height=0.8
    vim.g.floaterm_wintitle=0
    vim.g.floaterm_autoclose=1

    vim.cmd[[
        nnoremap <silent> <Space>tg :FloatermNew lazygit<CR>
        tnoremap <silent> <Space>tg <C-\><C-n>:FloatermNew lazygit<CR>
        nnoremap <silent> <Space>tt :FloatermToggle<CR>
        tnoremap <silent> <Space>tt <C-\><C-n>:FloatermToggle<CR>
    ]]

    -- local commands = {
    --     t = {
    --         name = "Terminal",
    --         t = {":FloatermToggle<CR>", "Toggle terminal"},
    --         o = {":FloatermNext<CR>", "Next terminal"},
    --         p = {":FloatermPrev<CR>", "Prev terminal"},
    --         n = {":FloatermNew<CR>", "New terminal"},
    --         w = {":FloatermKill<CR>", "Kill terminal"},
    --         r = {":FloatermNew ranger<CR>", "Ranger"},
    --         g = {":FloatermNew lazygit<CR>", "Lazygit"},
    --     }
    -- }
    -- local opts = require "plugins.config.which-key" . opts('n')
    --
    -- require("which-key") . register(commands, opts)
end

return M
