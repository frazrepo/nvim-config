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
    -- Reference from https://github.com/LazyVim/LazyVim/blob/132986a624b49bf740161d90ce94f16dd5ea5883/lua/lazyvim/plugins/editor.lua#L5
    -----------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"MunifTanjim/nui.nvim"},
        },
        init = function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.g.neo_tree_remove_legacy_commands  = true
        end,
        keys = {
            {
                "<C-n>",
                function()
                  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            {
                "<leader>e",
                function()
                  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },

        },
        opts = {
            sources = { "filesystem"},
            open_files_do_not_replace_types = { "terminal","qf"},
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
              },
            window = {
                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["<space>"] = "none",
                    ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c")
                    end,
                    desc = "Copy Path to Clipboard",
                    },
                    -- ["O"] = {
                    -- function(state)
                    --     require("lazy.util").open(state.tree:get_node().path, { system = true })
                    -- end,
                    -- desc = "Open with System Application",
                    },
                    ["P"] = { "toggle_preview", config = { use_float = false } },
                },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },                
        },
        config = function(_,opts)              
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
              pattern = "*lazygit",
              callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                  require("neo-tree.sources.git_status").refresh()
                end
              end,
            })
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
                "<leader>fm",
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
          spec = {
            {
              mode = { "n", "v" },
              { "<leader><tab>", group = "tabs" },
              { "<leader>b", group = "buffer" },
              { "<leader>c", group = "code/format/change" },
              { "<leader>f", group = "file/find" },
              { "<leader>g", group = "git" },
              { "<leader>gh", group = "hunks (diffview)" },
              { "<leader>gu", group = "toggle view" },
              { "<leader>i", group = "info", icon = { icon = "", color = "cyan" } },
              { "<leader>m", group = "miscellaneous", icon = { icon = "", color = "yellow" } },
              { "<leader>s", group = "search" },
              { "<leader>r", group = "replace" , icon = { icon = "󰄉 ", color = "yellow" } },
              { "<leader>t", group = "terminal" },
              { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
              { "<leader>w", group = "windows" },
              { "<leader>x", group = "diagnostics", icon = { icon = "󱖫 ", color = "green" } },
              { "g", group = "goto" },
              -- icon overrides
              { "<leader>e", name = "Explorer NeoTree (cwd)", icon = { icon = "󰉓 ", color = "yellow" } },
              { "<leader>p", name = "Open recent projects", icon = { icon = " ", color = "green" } },
            }
        }
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
}
