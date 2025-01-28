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
    -- Cannot lazy load as we need the remap of ] to ) at startup
    -----------------------------------------------------------
    {
        -- Need by vim-unimpaired to dot repeat operation like )<Space>
        'tpope/vim-repeat',
        lazy = false,
        pin = true,
    },
    {
        -- Useful for yo toggle and ) or ( commands
        'tpope/vim-unimpaired',
        lazy = false,
        pin = true,
        -- See mappings in lua/config/keymaps.lua    
    },

    -----------------------------------------------------------
    -- File explorer
    -----------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
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
            vim.keymap.set('n', '<C-n>', ':Neotree action=focus toggle=true<CR>',  { noremap = true, silent = true, desc = "Toggle neotree" })
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
        -- How to use
        -- Fill quickfix with search or something
        -- Press tab to mark some items
        -- Press zn or zN to create a new quickfix from these marked items
        --
        -- Or fill quickfix
        -- Press zf to filter
        -- Enter to open the item
        --
        -- As a general rule check mapping with <leader>? from which-key if needed
        -- Installation : 
        -- 'zf' command requires fzf
        {
            "kevinhwang91/nvim-bqf",
            opts = {},
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
        event = "VeryLazy",
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          preset = "helix",
        },
        keys = {
          {
            "<leader>?",
            function()
              require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
          },
        },
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

            vim.keymap.set('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, desc = "Search files" })
            vim.keymap.set('n', '<leader>p', "<cmd>Telescope projects<CR>", { noremap = true, desc = "Open Recent Projects" })
            vim.keymap.set('n', '<C-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, desc = "Live grep with telescope" })
            vim.keymap.set('n', '<leader>,', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true , desc = "Find buffer"})
            vim.keymap.set('n', '<leader>;', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", { noremap = true , desc = "Find lines in buffer" })
            vim.keymap.set("n", "<leader>u", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", {noremap = true, silent = true , desc = "Open Recent Files"})

        end
    },
}
