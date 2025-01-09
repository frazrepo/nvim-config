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

            vim.cmd[[
            nnoremap <silent> <Space>tg :FloatermNew lazygit<CR>
            tnoremap <silent> <Space>tg <C-\><C-n>:FloatermNew lazygit<CR>

            nnoremap <silent> <Space>tt :FloatermToggle<CR>
            tnoremap <silent> <Space>tt <C-\><C-n>:FloatermToggle<CR>

            nnoremap <silent> <Space>tw :FloatermKill<CR>
            tnoremap <silent> <Space>tw <C-\><C-n>:FloatermKill<CR>

            nnoremap <silent> <Space>tn :FloatermNew<CR>
            tnoremap <silent> <Space>tn <C-\><C-n>:FloatermNex<CR>

            nnoremap <silent> <Space>to :FloatermNext<CR>
            tnoremap <silent> <Space>to <C-\><C-n>:FloatermNext<CR>

            nnoremap <silent> <Space>tp :FloatermPrev<CR>
            tnoremap <silent> <Space>tp <C-\><C-n>:FloatermPrev<CR>

            ]]
        end,
        cmd = { "FloatermToggle", "FloatermNew" },
    },
    -- toggleterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
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