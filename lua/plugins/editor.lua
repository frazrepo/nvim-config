-----------------------------------------------------------
-- Editor features
-----------------------------------------------------------
return {
    -----------------------------------------------------------
    -- plenary : common lua libraries
    -----------------------------------------------------------
    {
        'nvim-lua/plenary.nvim',
        lazy  = true
    },

    -----------------------------------------------------------
    -- vim-unimpaired : various toggle, mappings
    -----------------------------------------------------------
    {
        'tpope/vim-unimpaired',
        keys = {
            { "(", mode = { "n", "o", "x" } },
            { ")", mode = { "n", "o", "x" } },
            { "yo", mode = { "n" } },
        },
        pin = true
    },

    -----------------------------------------------------------
    -- Folke ZenMode
    -----------------------------------------------------------
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
        },
        keys = {
            {"<leader>z", "<Cmd>ZenMode<CR>", desc= "Toggle zen mode"}
        }
    },
    -----------------------------------------------------------
    -- File explorer
    -----------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons"}, -- not strictly required, but recommended
            {"MunifTanjim/nui.nvim"},
        },
        init = function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.g.neo_tree_remove_legacy_commands  = true
        end,
        keys = {
            {"<C-n>", desc = "Toggle neotree"}
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    } ,
                    use_libuv_file_watcher = true,
                }
            })

            -- nvim-tree mappings
            local map = vim.api.nvim_set_keymap
            local default_opts = { noremap = true, silent = true  }
            map('n', '<C-n>', ':Neotree action=focus toggle=true<CR>', default_opts)
        end,
    },
    -- mini.files
    -- Usage : navigate using hjkl
    -- Manipalute file/dir creation like a normal buffer
    -- confirm operation with =
    -- Close dialog with q
    {
        'echasnovski/mini.files',
        version = '*',
        opts = {},
        keys = {
            {
                "-",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open mini.files (Directory of Current File)",
            },
            {
                "<leader>fM",
                function()
                    require("mini.files").open(vim.uv.cwd(), true)
                end,
                desc = "Open mini.files (cwd)",
            },
        },
    },    
    
    -----------------------------------------------------------
    -- Better Quickfix vim-bqf
    -----------------------------------------------------------
    {
        -- 'zf' requires fzf
        -- since changing fzf.vim for fzf-lua we don't need this anymore
        -- use `:lua require('fzf-lua').quickfix()` instead
        -- pcall(vim.cmd, [[PackerLoad fzf]])
        {
            "kevinhwang91/nvim-bqf",
            config = function()
                require('bqf').setup({
                    auto_enable = true,
                    auto_resize_height = true,
                    preview = {
                        auto_preview = false,
                    },
                    func_map = {
                        ptoggleauto = '<F2>',
                        ptogglemode = '<F3>',
                        split       = '<C-s>',
                        vsplit      = '<C-v>',
                        pscrollup   = '<S-up>',
                        pscrolldown = '<S-down>',
                    },
                    filter = {
                        fzf = {
                            action_for = {['ctrl-s'] = 'split'},
                            extra_opts = {'--bind', 'ctrl-a:toggle-all', '--prompt', '> '}
                        }
                    }
                })
            end,
            ft = { 'qf' }
        },

        -- fzf , needs to install fzf exe
        {
            'junegunn/fzf',
            run = function()
                vim.fn['fzf#install']()
            end
        },

    },

    -----------------------------------------------------------
    -- Keep last place on start
    -----------------------------------------------------------
    {
        "ethanholz/nvim-lastplace",
        event = "BufReadPre",
        opts = {}
    },

    -----------------------------------------------------------
    -- Plugin: whichkey
    -- https://github.com/folke/which-key.nvim
    -----------------------------------------------------------
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to the default settings
                -- refer to the configuration section below
            })
            local wk = require("which-key")

            wk.add({
                { "<leader>", group = "Leader" },
                { "<leader>!", desc = "Delete buffer" },
                { "<leader>,", desc = "Find buffer" },
                { "<leader>/", desc = "Global Search" },
                { "<leader>;", desc = "Find lines in buffer" },
                { "<leader>G", desc = "Global Search in buffers" },
                { "<leader>cd", desc = "Change to current buffer directory" },
                { "<leader>d", desc = "Edit markdown buffer" },
                { "<leader>e", desc = "Edit in current buffer path" },
                { "<leader>fr", desc = "Find Replace Visually" },
                { "<leader>m", desc = "Remove special char M" },
                { "<leader>r", desc = "Replace Search Register" },
                { "<leader>s", desc = "Edit sql buffer" },
                { "<leader>te", desc = "Tab Edit in current buffer path" },
                { "<leader>u", desc = "Open Recent File" },
                { "<leader>w", desc = "Save buffer" },
                { "<leader>x", desc = "Edit txt buffer" },
                { "g", group = "Buffer" },
                { "gV", desc = "Reselect last pasted text" },
                { "gb", desc = "Block Comment" },
                { "gc", desc = "Comment" },
                { "g=", desc = "Indent buffer" },
                { "gQ", desc = "Format buffer" },
                { "gv", desc = "Reselect last visual selection" },
            })
        end,
    },

    -----------------------------------------------------------
    -- Telescope configuration file
    -- Plugin: nvim-telescope
    -- telescope fuzzy finder + fzf-native sorter
    -- https://github.com/nvim-telescope/telescope.nvim
    -----------------------------------------------------------
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup{
                defaults = {
                    file_ignore_patterns = {"node_modules"},
                    preview = false,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                    },
                    oldfiles = {
                        theme = "dropdown",
                    },
                    buffers = {
                        theme = "dropdown",
                    },
                    live_grep = {
                        theme = "dropdown",
                    }
                },
            }

            require('telescope').load_extension('projects')

            vim.api.nvim_set_keymap('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>p', "<cmd>Telescope projects<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<C-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>,', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>;', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<leader>u", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", {noremap = true, silent = true})

        end
    },
    -----------------------------------------------------------
    -- Buffer Helpers
    -----------------------------------------------------------
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


    -- mini.Align - ga simple and gA interactive
    {
        'echasnovski/mini.align',
        opts = {},
        keys = {
            { "ga", desc = "Align" },
            { "gA", desc = "Align interactive" },
            { "ga", mode = "x" },
        },
    },

    -- minioperators  : Sort (gs), Replace with register (gr), Exchange text regions (gx/gxx), Multiply text (gm/gmm),
    { 
        'echasnovski/mini.operators',
         version = '*' ,
         opts = {},
         keys = { 
            { "gs" , desc= "Sort text region" },
            { "gx" , desc= "Exchange text region" },
            { "gm" , desc= "Multiply text region" },
            { "gr" , desc= "Replace with register" },
            -- { "g=" , "Evaluate text and replace" }, -- Already used to indent buffer
         }
    },
}
