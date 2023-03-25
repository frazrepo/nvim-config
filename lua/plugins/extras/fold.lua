 -- Custom plugins or experimental plugins here
return {
    -- nvim ufo
    -- see settings.lua for fold* options
    -- todo : use https://github.com/luukvbaal/statuscol.nvim but needs nvim > 0.9
    {
        'kevinhwang91/nvim-ufo',
        config = function()
            -- default mapping zR openAllFolds, zM closeAllFolds
            require('ufo').setup(
              {
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
              }
            )
        end,
        dependencies = 'kevinhwang91/promise-async'

    },
}
