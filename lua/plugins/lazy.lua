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

local fzconfig = require("fzconfig")

require("lazy").setup({

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
    'tpope/vim-unimpaired' ,

    'tpope/vim-surround' ,

    --  repeat surround action
    'tpope/vim-repeat',

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
            { "X" , mode = "x" },
        },
    },

    -- transpose
    -- If not working on *unix
    -- Convert plugin/transpose.vim and autoload/transpose.vim with dos2unix
    {
        "vim-scripts/Transpose",
        cmd = {
            "Transpose", "TransposeWords", "TransposeCSV", "TransposeTab", "TransposeInteractive"
        },
    },

    -- Align based on character (mapping gl)
    {
        'tommcdo/vim-lion',
        keys = {
            { "gl" },
            { "gl" , mode = "x" },
        },
    },

    -- Aligning (mapping ga , replace gl when config is stable)
    {
        "junegunn/vim-easy-align",
        config = function()
            -- require "rmagatti.easyalign"
            vim.cmd [[
                " Start interactive EasyAlign in visual mode (e.g. vipga)
                xmap ga <Plug>(EasyAlign)
                " Start interactive EasyAlign for a motion/text object (e.g. gaip)
                nmap ga <Plug>(EasyAlign)
                " Align GitHub-flavored Markdown tables
                augroup aligning
                au!
                au FileType markdown vmap <leader><Bslash> :EasyAlign*<bar><CR>
                augroup end
                ]]
        end,
        keys = {
            { "ga" },
            { "ga" , mode = "x" },
        },
        cmd = { "EasyAlign" },
    },

    -- vim-sort-motion (mapping gs)
    {
        "christoomey/vim-sort-motion",
        keys = {
            { "gss" },
            { "gs" },
            { "gs" , mode = "x" },
        },
    },

    -- Replace with Register
    {
        'vim-scripts/ReplaceWithRegister'
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

    -- file explorer neo-tree instead of nvim-tree
    -- {
    --     'kyazdani42/nvim-tree.lua',
    --     config = function()
    --         require("plugins.nvim-tree")
    --     end
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons"}, -- not strictly required, but recommended
            {"MunifTanjim/nui.nvim"},
        },
        config = function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = true,
                }

            })

            -- nvim-tree mappings
            local map = vim.api.nvim_set_keymap
            local default_opts = { noremap = true, silent = true  }
            map('n', '<C-n>', ':Neotree action=focus toggle=true<CR>', default_opts)       -- open/close
            -- map('n', '<leader>n', ':NeoTreeFloatToggle<CR>', default_opts) -- open/close in floating windows

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

-----------------------------------------------------------
-- Completion , LSP
-----------------------------------------------------------
-- coc nvim
{
    'neoclide/coc.nvim',
    -- branch = 'release',
    tag = 'v0.0.81',
    config= function()
        require('plugins.coc')
    end
},

{

    'honza/vim-snippets'
},

-- null-ls
{
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
       { 'nvim-lua/plenary.nvim'}
    },
    config = function()
        require('plugins.null-ls')
    end,
},

-- Trouble Diagnostics List
{
  "folke/trouble.nvim",
  dependencies = {{ 'kyazdani42/nvim-web-devicons'}},
  config = function()
    require("trouble").setup {
    }
  end
},
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

    -- lightspeed (Advantage : the label is on the third char)
    {
        'ggandor/lightspeed.nvim',
        config = function()
            require 'lightspeed'.setup {
                labels = { "s", "f", "n", "j", "k", "l", "o", "i", "w", "e", "h", "g", "u", "t", "m", "v", "c", "a", "z" }
            }

            --disabling f F t T
            vim.api.nvim_set_keymap("n", "f", "f", { silent = true })
            vim.api.nvim_set_keymap("n", "F", "F", { silent = true })
            vim.api.nvim_set_keymap("n", "t", "t", { silent = true })
            vim.api.nvim_set_keymap("n", "T", "T", { silent = true })

        end
    },

    -----------------------------------------------------------
    -- UI enhacements
    -----------------------------------------------------------

    -- colors
    {
        'folke/tokyonight.nvim'
    },

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
        dependencies = {{ 'kyazdani42/nvim-web-devicons'}},
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
        dependencies = {{'kyazdani42/nvim-web-devicons'}},
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
    {
        'kevinhwang91/nvim-ufo',
        config = function()
            -- default mapping zR openAllFolds, zM closeAllFolds
            require('ufo').setup(
              {
                provider_selector = function(bufnr, filetype, buftype)
                  return {"treesitter", "indent"}
                end
              }
            )
        end,
        dependencies = 'kevinhwang91/promise-async'

    },

    -----------------------------------------------------------
    -- Terminal enhacements
    -----------------------------------------------------------

    -- toggleterm and floatterm
    {
        "akinsho/toggleterm.nvim",
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
