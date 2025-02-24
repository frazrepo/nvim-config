-----------------------------------------------------------
-- UI enhacements
-----------------------------------------------------------
return {
    { 
        'echasnovski/mini.icons', 
        version = false,
        config = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end
    },
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = {}
    },

    -- gitsign
    {
        'lewis6991/gitsigns.nvim',
        -- event : LazyFile = { "BufReadPost", "BufWritePost", "BufNewFile" } 
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
        keys = {
            { "<leader>gb"  },
            { '<leader>guw' },
            { '<leader>guL' },
            { '<leader>guv' },
        },
       config = function()
         require('gitsigns').setup()
         vim.keymap.set( 'n', '<leader>gb',require("gitsigns").blame, { desc = 'git blame' })
         -- Highlight word diff
         vim.keymap.set( 'n', '<leader>guw', require('gitsigns').toggle_word_diff, { desc = 'Toggle word diff' })
         -- Highlight added lines.
         vim.keymap.set( 'n', '<leader>gul', require('gitsigns').toggle_linehl, { desc = 'Toggle line highlight' })
         -- Preview hunk inline
         vim.keymap.set( 'n', '<leader>guv', require('gitsigns').preview_hunk_inline, { desc = 'Toggle preview inline' })
       end
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
            { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "(b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { ")b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "<b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
            { ">b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        config = function(_,opts)
            require('bufferline').setup(opts)
        end
    },
}
