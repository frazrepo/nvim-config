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
    config = function()
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
    --
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

    -- splitjoin
    -- mapping conflict with <leader>s , sql buffer
    -- {
    --     'Wansmer/treesj',
    --     keys = { '<space>m', '<space>j', '<space>s' },
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --     config = function()
    --         require('treesj').setup({--[[ your config ]]})
    --     end,
    -- },
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
            map('n', '<C-n>', ':Neotree action=focus toggle=true<CR>', default_opts)       -- open/close
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
    -- Completion , LSP
    -----------------------------------------------------------

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required

            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            -- {'rafamadriz/friendly-snippets'}, -- Optional
            {'frazrepo/friendly-snippets'}, -- Optional
        },
        config = function()
            require('plugins.lsp-zero')
        end,
    },

    -- mason-tool-installer to install tools used by mason
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup {
                -- a list of all tools you want to ensure are installed upon
                -- start; they should be the names Mason uses for each tool
                ensure_installed = {
                },
            }
        end,
    },

    -- null-ls with prettier
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require('plugins.null-ls')
        end,
    },

    -- make mason and null-ls work seamlessly
    {
        "jay-babu/mason-null-ls.nvim"
    },

    -- lspkind : pictograms or icons like vscode LSP
    { 'onsails/lspkind-nvim' },

    -- lsp signature : display function signature
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require "lsp_signature".setup()
        end
    },
    -- Trouble : Display diagnostics List in quickfix windows
    {
        "folke/trouble.nvim",
        dependencies = {
            {"kyazdani42/nvim-web-devicons"}
        },
        config = function()
            require("trouble").setup {
            }
        end
    },

    -- Miscellaneous

    -----------------------------------------------------------
    -- Helpers
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

    -- hop (better and simpler than lightspeed) Need more experimentation
    -- {
    --     'phaazon/hop.nvim',
    --     branch = 'v1', -- optional but strongly recommended
    --     event = "BufRead",
    --     cmd = {"HopChar2", "HopWord"},
    --     config = function()
    --         -- you can configure Hop the way you like here; see :h hop-config
    --         require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    --         -- vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('hop').hint_words()<cr>", {})
    --         vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
    --         vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    --
    --     end
    -- }

    -- leap like next version of lightspeed
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
    },
    -- easily jump to any location and enhanced f/t motions for Leap
    {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
    },

    -- session management
    -- depends on vim.o.sessionoptions (see settings.lua)
    -- :SaveSession " saves or creates a session in the currently set `auto_session_root_dir`.
    -- :SaveSession ~/my/custom/path " saves or creates a session in the specified directory path.
    -- :RestoreSession " restores a previously saved session based on the `cwd`.
    -- :RestoreSession ~/my/custom/path " restores a previously saved session based on the provided path.
    -- :RestoreSessionFromFile ~/session/path " restores any currently saved session
    -- :DeleteSession " deletes a session in the currently set `auto_session_root_dir`.
    -- :DeleteSession ~/my/custom/path " deleetes a session based on the provided path.
    -- :Autosession search
    -- :Autosession delete
    -- Bug : tab not working after command@
    -- weird things when switching between sessions (conflicts with lualine ?)
    -- deleting session seems to not working

    {
        'rmagatti/auto-session',
        config = function()
          require("auto-session").setup {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
          }

        end
    },
    {
      'rmagatti/session-lens',
      dependencies = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
      config = function()
        require('session-lens').setup({--[[your custom config--]]})
        vim.api.nvim_set_keymap("n", "<leader>as", "<Cmd>Telescope session-lens search_session<CR>", {noremap = true, silent = true})
        -- Allow to specify name for a session
        vim.api.nvim_set_keymap("n",'<leader>an', ":lua require('auto-session').SaveSession(require('auto-session').get_root_dir() .. vim.fn.input('SessionName > ')) <CR>", {noremap = true, silent = true})
      end
    },

    -- Alternative neovim session manager
    -- bug avec des splits ? : works after restart
    -- Another bug: seems to not working correctly when switching between sessions
    -- {
    --     "shatur/neovim-session-manager",
    --     config = function()
    --         require('session_manager').setup({
    --             autoload_mode = require('session_manager.config').AutoloadMode.Disabled,             })
    --         vim.api.nvim_set_keymap("n", "<leader>s", "<Cmd>SessionManager load_session<CR>", {noremap = true, silent = true})
    --     end,
    --     dependencies = {'stevearc/dressing.nvim'}
    -- },

   -- Alternative : possession
   -- Commands : Possession* or Alias S*
   -- Telescope integration : :Telescope possession list
   {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- setup
            require('possession').setup({
                autosave = {
                    current = true,
                    -- tmp = true,
                    -- tmp_name = 'tmp',
                    on_load = true,
                    on_quit = true,
                },
                commands = {
                    save = "SSave",
                    load = "SLoad",
                    delete = "SDelete",
                    list = "SList",
                },
            })
            -- telescope integration
            require('telescope').load_extension('possession')
            vim.api.nvim_set_keymap("n", "<leader>aa", "<Cmd>Telescope possession list<CR>", {noremap = true, silent = true})
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

    -- nvim ufo
    -- see settings.lua for fold* options
    -- todo : use https://github.com/luukvbaal/statuscol.nvim but needs nvim > 0.9
    -- {
    --     'kevinhwang91/nvim-ufo',
    --     config = function()
    --         -- default mapping zR openAllFolds, zM closeAllFolds
    --         require('ufo').setup(
    --           {
    --             provider_selector = function(bufnr, filetype, buftype)
    --               -- return {"treesitter", "indent"}
    --                 local function handleFallbackException(bufnr, err, providerName)
    --                   if type(err) == "string" and err:match "UfoFallbackException" then
    --                     return require("ufo").getFolds(bufnr, providerName)
    --                   else
    --                     return require("promise").reject(err)
    --                   end
    --                 end

    --                 return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
    --                   or function(bufnr)
    --                     return require("ufo")
    --                       .getFolds(bufnr, "lsp")
    --                       :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
    --                       :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
    --                   end
    --             end
    --           }
    --         )
    --     end,
    --     dependencies = 'kevinhwang91/promise-async'

    -- },

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
    }

})
