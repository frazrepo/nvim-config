-- or to disable to file
-- if true then return {} end

return {
    -- vim gtfo - open files in terminal/explorer
    {
        'justinmk/vim-gtfo'
    },

    -- splitjoin
    -- mapping conflict with <leader>s , sql buffer
    -- jk : toggle, jj : join, js : split
    {
        'Wansmer/treesj',
        keys = { '<space>jk', '<space>jj', '<space>js' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,    
            })
            -- For use default preset and it work with dot
            vim.keymap.set('n', '<leader>jk', require('treesj').toggle, {silent = false, desc = "SplitJoin Toggle"})
            vim.keymap.set('n', '<leader>jj', require('treesj').join,{ desc = "SplitJoin Join"})
            vim.keymap.set('n', '<leader>js', require('treesj').split, { desc = "SplitJoin Split"})
        end,
    },

}