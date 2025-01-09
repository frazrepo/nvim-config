return {
    -----------------------------------------------------------
    -- Motions
    -----------------------------------------------------------

    -- leap like next version of lightspeed
    -- s{char1}{char2} then jump to next /previous with Enter/Tab
    -- operator mode (till) :  x/X{char1}{char2} : eg dxca (before ca)
    -- operator mode (to) : replace s/S with z/Z : dzca (include)
    -- x/X -->  z/Z : t/T --> f/F
    -- visual mode : vx/X{char1}{char2} , vz/Z (vS not working, taken by surround)
    -- s space space : blank line
    -- s char space: char + end of line
    {
        'ggandor/leap.nvim',
        config = function()
            -- require('leap').add_default_mappings()
            -- Override operator pending mode (conflict with nvim-surround)
            vim.keymap.set({'n'}, 's', '<Plug>(leap-forward-to)')
            vim.keymap.set({'n'}, 'S', '<Plug>(leap-backward-to)')
            vim.keymap.set({'x', 'o'}, 'x', '<Plug>(leap-forward-till)')
            vim.keymap.set({'x', 'o'}, 'X', '<Plug>(leap-backward-till)')
            vim.keymap.set({'x', 'o'}, 'z', '<Plug>(leap-forward-to)')
            vim.keymap.set({'x', 'o'}, 'Z', '<Plug>(leap-backward-to)')
        end,
    },
}
