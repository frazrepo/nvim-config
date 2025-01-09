return  {
    -----------------------------------------------------------
    -- Buffer Helpers
    -----------------------------------------------------------
    -- tim pope plugins
    {
        'tpope/vim-unimpaired',
        pin = true
    } ,


    --  repeat surround action
    {
        'tpope/vim-repeat',
        pin = true
    },

    -- surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- vim-exchange exchange lines
    {
        "tommcdo/vim-exchange",
        keys = {
            { "cx" },
            { "X", mode = "x" },
        },
        pin = true
    },

    -- transpose
    -- If not working on *unix
    -- Convert plugin/transpose.vim and autoload/transpose.vim with dos2unix
    {
        "vim-scripts/Transpose",
        cmd = {
            "Transpose", "TransposeWords", "TransposeCSV", "TransposeTab", "TransposeInteractive"
        },
        pin = true
    },

    -- Align based on character (mapping gl)
    {
        'tommcdo/vim-lion',
        keys = {
            { "gl" },
            { "gl", mode = "x" },
        },
        pin = true
    },

    -- Aligning (mapping ga , replace gl when config is stable)
    {
        "junegunn/vim-easy-align",
        config = function()
            -- require "rmagatti.easyalign"
            -- nvim-tree mappings
            local map = vim.api.nvim_set_keymap
            local default_opts = { noremap = false, silent = true  }
            map('x', 'ga', '<Plug>(EasyAlign)', default_opts)
            map('n', 'ga', '<Plug>(EasyAlign)', default_opts)
        end,
        keys = {
            { "ga" },
            { "ga", mode = "x" },
        },
        cmd = { "EasyAlign" },
    },

    -- vim-sort-motion (mapping gs)
    {
        "christoomey/vim-sort-motion",
        keys = {
            { "gss" },
            { "gs" },
            { "gs", mode = "x" },
        },
        pin = true
    },

    -- Replace with Register
    {
        'vim-scripts/ReplaceWithRegister',
        pin = true
    },

    -- Move lines with <A-j> <A-k>
    {
        'matze/vim-move'
    },

    -----------------------------------------------------------
    -- Utils
    -----------------------------------------------------------

    -- plenary : common lua libraries
    {
        'nvim-lua/plenary.nvim'
    },

    -- ripgrep integration
    {
        'BurntSushi/ripgrep'
    },

    -----------------------------------------------------------
    -- Miscellaneous ,Helpers
    -----------------------------------------------------------

    -- Project Management
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to the default settings
                -- refer to the configuration section below
            }
        end
    },
}
