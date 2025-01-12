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
    -- File explorer  neo-tree
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
                { "g=", desc = "Format buffer" },
                { "gL", desc = "Go align left" },
                { "gQ", desc = "Format buffer" },
                { "gV", desc = "Reselect last pasted text" },
                { "ga", desc = "Easy Align Operator" },
                { "gb", desc = "Block Comment" },
                { "gc", desc = "Comment" },
                { "gl", desc = "Go align right" },
                { "gq", desc = "Format" },
                { "gs", desc = "Sort operator" },
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
        keys = {
            { "gr" },
            { "gr", mode = "x" },
        },
        pin = true
    },

    -- Move lines with <A-j> <A-k>
    {
        'matze/vim-move',
        keys = {
            { "<A-j>" },
            { "<A-j>", mode = "v" },
            { "<A-k>" },
            { "<A-k>", mode = "v" },
        },
        pin = true
    },    
}
