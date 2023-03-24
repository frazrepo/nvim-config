-- Discard if provider is native lsp
if vim.g.lspprovider == 'native' then return {} end

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