-----------------------------------------------------------
-- UI enhacements
-----------------------------------------------------------
return {
    -- cursorline
    {
        'yamatsum/nvim-cursorline',
        config = function ()
            require('nvim-cursorline').setup {
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                }
            }
        end
    },

    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            {"kyazdani42/nvim-web-devicons"}
        },
        event = "VeryLazy",
        opts = {}
    },

    -- gitsign
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
        opts = {},
        keys = {
            { "<leader>gb", "<Cmd>Gitsigns blame<CR>", desc = "Git blame" },
        }
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        dependencies = {
            {'kyazdani42/nvim-web-devicons'}
        },
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
