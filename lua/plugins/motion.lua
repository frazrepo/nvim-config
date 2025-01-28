    -----------------------------------------------------------
    -- Motions
    -----------------------------------------------------------
    return {
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

        -- Flit : easily jump to any location and enhanced f/t motions for Leap
        -- Can jump/previous on the next occurence with <CR>/<Tab>
        {
            "ggandor/flit.nvim",
            dependencies ={ "ggandor/leap.nvim"},
            event = "VeryLazy",
            config = function(_, opts)
                require('flit').setup {
                    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
                    -- A string like "nv", "nvo", "o", etc.
                    labeled_modes = "v",
                    multiline = true,
                    -- Like `leap`s similar argument (call-specific overrides).
                    -- E.g.: opts = { equivalence_classes = {} }
                    opts = {}
                }
            end,
        },

        -- mini-move
        {
            'echasnovski/mini.move',
            version = '*',
            opts = {},
            keys = {
                { "<A-j>" },
                { "<A-j>", mode = "v" },
                { "<A-k>" },
                { "<A-k>", mode = "v" },
            },
        },
}
