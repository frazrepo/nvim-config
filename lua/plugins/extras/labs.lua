-- or to disable to file
-- if true then return {} end

return {

    -- Added : 19/04/2023
    -- Configure with :Copilot auth
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({})
    --     end,
    -- },

    -- Added : 24/03/2023
    -- vim gtfo - open files in terminal/explorer
    -- Windows : gof (ok), got (ko)
    {
        'justinmk/vim-gtfo'
    },

    -- Added : 25/03/2023
    -- splitjoin
    -- mapping conflict with <leader>s , sql buffer
    -- kk : toggle, kj : join, ks : split
    {
        'Wansmer/treesj',
        keys = { '<space>kk', '<space>kj', '<space>ks' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
            -- For use default preset and it work with dot
            vim.keymap.set('n', '<leader>kk', require('treesj').toggle, {silent = false, desc = "SplitJoin Toggle"})
            vim.keymap.set('n', '<leader>kj', require('treesj').join,{ desc = "SplitJoin Join"})
            vim.keymap.set('n', '<leader>ks', require('treesj').split, { desc = "SplitJoin Split"})
        end,
    },

    -- Added on 14/04/2023
    -- neoscroll for smooth scrolling with C-d /C-u ...
    {
        'karb94/neoscroll.nvim',
        config = function ()
            require('neoscroll').setup()
        end,
        event = "VeryLazy"
    },

    -- -- Added on 19/12/2023
    -- {
    --     'github/copilot.vim',
    -- }



}
