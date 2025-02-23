
-- or to disable to file
-- if true then return {} end

return {
    -----------------------------------------------------------
    -- Completion , LSP
    -----------------------------------------------------------
    -- coc nvim
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config= function()
            require('plugins.coc.config')
        end
    },

    -- Snippets
    {
        'honza/vim-snippets'
    },
}
