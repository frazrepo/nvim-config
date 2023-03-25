-- or to disable to file
-- if true then return {} end

return {
    -- vim gtfo - open files in terminal/explorer
    {
        'justinmk/vim-gtfo'
    },

    -- splitjoin
    -- mapping conflict with <leader>s , sql buffer
    {
        'Wansmer/treesj',
        keys = { '<space>jm', '<space>jj', '<space>js' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({--[[ your config ]]})
        end,
    },

}