-----------------------------------------------------------
-- Plugin manager configuration file
-- Plugin manager: lazy.nvim
-- https://github.com/folke/lazy.nvim
-----------------------------------------------------------
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

-----------------------------------------------------------
-- ColorScheme
-----------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
    -- load the colorscheme here
    --   vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "catppuccin/nvim",
    config =  function()
        -- load the colorscheme here
        vim.cmd([[colorscheme catppuccin]])
    end,
  },

-----------------------------------------------------------
-- Buffer Helpers
-----------------------------------------------------------

    -- tim pope plugins
    {
        'tpope/vim-unimpaired',
        pin = true
    } ,

    -- {
    --     'tpope/vim-surround',
    --     pin = true
    -- } ,

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

    -- Enhanced comment plugin + TreeSitter context commentstring
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring'
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

    -- Text objects
    { 'coderifous/textobj-word-column.vim' },
    { 'michaeljsmith/vim-indent-object' },
    {
        "wellle/targets.vim",
        event = { "BufReadPost" },
    },

    -- move lines with <A-j> <A-k>
    { 'matze/vim-move' },

    -----------------------------------------------------------
    -- Code Helpers - Code Generation
    -----------------------------------------------------------

    -- treesitter interface : syntax highlighter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.treesitter')
        end
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = "nvim-treesitter"
    },

    -- emmet html/css snippets
    {
        "mattn/emmet-vim",
        ft = {
            "html",
            "css",
            "typescript",
            "typescriptreact",
            "javascriptreact",
            "javascript",
        },
        config = function()
            require("plugins.emmet").setup()
        end,
    },

    -- autorename tags
    {
        'AndrewRadev/tagalong.vim',
    },

    -- autopairs
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    },

    -- autotags (see treesitter for activation)
    -- Need to install parser for html /xml :TSInstall html
    {
        'windwp/nvim-ts-autotag',
        ft = {
            "html",
            "xml",
        },
    },

    -- neoformat
    {
        'sbdchd/neoformat',
    },

    -----------------------------------------------------------
    -- Search Replace
    -----------------------------------------------------------

    -- vim-grepper
    { "mhinz/vim-grepper",
        config = function()
            require("plugins.vim-grepper")
        end,
    },

    -----------------------------------------------------------
    -- Explorer : file, buffers, quickfix
    -----------------------------------------------------------

    -- telescope fuzzy finder + fzf-native sorter
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require("plugins.telescope")
        end
    },

    -- file explorer  neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons"}, -- not strictly required, but recommended
            {"MunifTanjim/nui.nvim"},
        },
        init = function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.g.neo_tree_remove_legacy_commands  = true
        end,
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = true,
                    use_libuv_file_watcher = true,
                }
            })

            -- nvim-tree mappings
            local map = vim.api.nvim_set_keymap
            local default_opts = { noremap = true, silent = true  }
            map('n', '<C-n>', ':Neotree action=focus toggle=true<CR>', default_opts)
        end,
    },

    -- quickfix vim-bqf
    {
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.bqf")
        end,
        ft = { 'qf' }
    },

    -- fzf , needs to install fzf exe
    {'junegunn/fzf', run = function()
        vim.fn['fzf#install']()
    end
    },

    -----------------------------------------------------------
    -- Completion , LSP or coc
    -----------------------------------------------------------

    require('plugins.coc'),

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

    -- which-key
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to the default settings
                -- refer to the configuration section below
            }
            require('plugins.whichkey')
        end
    },

    -- Keep last place on start
    {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup {
            }
        end
    },


    -- leap like next version of lightspeed
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
    },

    -----------------------------------------------------------
    -- UI enhacements
    -----------------------------------------------------------
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
        config = function()
            require('lualine').setup()
        end
    },

    -- gitsign
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
        config = function()
            require('gitsigns').setup()
        end
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

    -- indent blankline
    { "lukas-reineke/indent-blankline.nvim" },

    -- truezen
    {
        "Pocco81/TrueZen.nvim",
        config = function()
            local default_opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<F12>", [[<Cmd>TZAtaraxis<CR>]], default_opts)
        end
    },

    -----------------------------------------------------------
    -- Terminal enhacements
    -----------------------------------------------------------

    -- toggleterm and floatterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup(
                {
                    open_mapping = [[<c-t>]],
                    close_on_exit = true
                }
            )
        end,
    },

    {
        "voldikss/vim-floaterm",
        init = function()
            require "plugins.floaterm".setup()
        end,
        -- cmd = "FloatermNew",
        cmd = { "FloatermToggle", "FloatermNew" },
    },

    -----------------------------------------------------------
    -- Extras plugins or experimental plugins in lua/plugins/extras
    -----------------------------------------------------------
    { import = 'plugins.extras' },

})
