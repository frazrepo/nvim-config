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
        opts = {}
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            {'kyazdani42/nvim-web-devicons'}
        },
        init = function()
            vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
        end,
        config = function()
            require('bufferline').setup({
                options = {
                    offsets = {
                        { filetype = 'NvimTree', text = 'File Explorer' },
                    },
                }
            })
        end
    },
}
