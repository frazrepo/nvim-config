
-- or to disable to file
-- if true then return {} end

return {
    -----------------------------------------------------------
    -- Completion , LSP
    -----------------------------------------------------------
    -- coc nvim
    {
        'neoclide/coc.nvim',
        -- branch = 'release',
        tag = 'v0.0.81',
        config= function()
            require('plugins.coc.config')
        end
    },

    -- Snippets
    {
        'honza/vim-snippets'
    },
}