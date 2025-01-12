-----------------------------------------------------------
-- Terminal plugin
-----------------------------------------------------------
return {
    {
        "voldikss/vim-floaterm",
        init = function()
            vim.g.floaterm_gitcommit='floaterm'
            vim.g.floaterm_autoinsert=1
            vim.g.floaterm_width=0.8
            vim.g.floaterm_height=0.8
            vim.g.floaterm_wintitle=0
            vim.g.floaterm_autoclose=1

            vim.keymap.set('n', '<Space>tg', ':FloatermNew lazygit<CR>', { silent = true })
            vim.keymap.set('n', '<Space>tt', ':FloatermToggle<CR>', { silent = true })
            vim.keymap.set('n', '<Space>tw', ':FloatermKill<CR>', { silent = true })
            vim.keymap.set('n', '<Space>tn', ':FloatermNew<CR>', { silent = true })
            vim.keymap.set('n', '<Space>to', ':FloatermNext<CR>', { silent = true })
            vim.keymap.set('n', '<Space>tp', ':FloatermPrev<CR>', { silent = true })
        end,
        cmd = { "FloatermToggle", "FloatermNew" },
    },
    -- toggleterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = [[<c-t>]],
        cmd = "ToggleTerm",
        config = function()
            require("toggleterm").setup(
            {
                open_mapping = [[<c-t>]],
                close_on_exit = true
            }
            )
        end,
    },
}
