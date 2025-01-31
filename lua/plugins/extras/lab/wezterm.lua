
return {

    { 
        'mrjones2014/smart-splits.nvim',
        -- opts = {},
        config = function()
            require('smart-splits').setup()
            -- moving between splits
            vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
        end
    },
	-- Added on 20250104
	-- wezterm and nvim compatibility
    -- Alternative : https://github.com/mrjones2014/smart-splits.nvim
    -- {
    --     "letieu/wezterm-move.nvim",
    --     enabled = false,
    --     keys = { -- Lazy loading, don't need call setup() function
    --         { "<C-h>", function() require("wezterm-move").move "h" end },
    --         { "<C-j>", function() require("wezterm-move").move "j" end },
    --         { "<C-k>", function() require("wezterm-move").move "k" end },
    --         { "<C-l>", function() require("wezterm-move").move "l" end },
    --     },
    -- },
}
