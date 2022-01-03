-----------------------------------------------------------
-- Plugin manager configuration file
-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim
-----------------------------------------------------------
--
local execute = vim.api.nvim_command

-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0

if not is_installed then
    if vim.fn.input("Install packer.nvim? (y for yes) ") == "y" then
        execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
        execute("packadd packer.nvim")
        print("Installed packer.nvim.")
        is_installed = 1
    end
end


-- Packer commands
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

local packer = nil
if not is_installed then return end
if packer == nil then
    packer = require('packer')
    packer.init({
        -- we don't want the compilation file in '~/.config/nvim'
        compile_path = compile_path
    })
end

local use = packer.use

local fzconfig = require("fzconfig")

-- Add packages
-----------------------------------------------------------
-- Packer itself
-----------------------------------------------------------

-- packer can manage itself
use 'wbthomason/packer.nvim'

-----------------------------------------------------------
-- Buffer Helpers
-----------------------------------------------------------

-- tim pope plugins
use 'tpope/vim-unimpaired'
use 'tpope/vim-surround'

--  repeat surround action
use 'tpope/vim-repeat'

-- Enhanced comment plugin + TreeSitter context commentstring
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
use 'JoosepAlviste/nvim-ts-context-commentstring'

-- vim-exchange exchange lines
use {
    "tommcdo/vim-exchange",
    keys = {
        { "n", "cx" },
        { "x", "X" },
    },
}

-- transpose
-- If not working on *unix
-- Convert plugin/transpose.vim and autoload/transpose.vim with dos2unix
use {
    "vim-scripts/Transpose",
    cmd = {
       "Transpose","TransposeWords","TransposeCSV","TransposeTab","TransposeInteractive"
    },
}

-- Align based on character (mapping gl)
use {
    'tommcdo/vim-lion',
    keys = {
        { "n", "gl" },
        { "x", "gl" },
    },
}

-- Aligning (mapping ga , replace gl when config is stable)
use {
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
        { "n", "ga" },
        { "x", "ga" },
    },
    cmd = { "EasyAlign" },
}

-- vim-sort-motion (mapping gs)
use {
    "christoomey/vim-sort-motion",
    keys = {
        { "n", "gss" },
        { "n", "gs" },
        { "x", "gs" },
    },
}

-- Text objects
use {'coderifous/textobj-word-column.vim'}
use {'michaeljsmith/vim-indent-object'}
use {
    "wellle/targets.vim",
    event = { "BufReadPost" },
}

-- move lines with <A-j> <A-k>
use {'matze/vim-move'}

-----------------------------------------------------------
-- Code Helpers - Code Generation
-----------------------------------------------------------

-- treesitter interface : syntax highlighter
use {
    'nvim-treesitter/nvim-treesitter',
    config= function()
        require('plugins.treesitter')
    end
}

use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = "nvim-treesitter"
}

-- emmet html/css snippets
use {
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
}

-- autopairs
use {
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup{}
    end
}

-- autotags (see treesitter for activation)
use {
    'windwp/nvim-ts-autotag',
    ft = {
        "html",
        "xml",
    },
}

-----------------------------------------------------------
-- Search Replace
-----------------------------------------------------------

-- vim-grepper

use {"mhinz/vim-grepper",
    cmd = { 'Grepper', 'GrepperRg', 'GrepperAg', 'GrepperGrep' },
    config = function()
        require("plugins.vim-grepper")
    end,
    keys = {
        { "n", "gx" },
        { "x", "gx" },
        { "n", "<leader>g" },
        { "x", "<leader>g" },
        { "n", "<leader>/" },
        { "x", "<leader>/" },
        { "n", "<leader>G" },
        { "x", "<leader>G" },
    },
}

-----------------------------------------------------------
-- Explorer : file, buffers, quickfix
-----------------------------------------------------------

-- telescope fuzzy finder + fzf-native sorter
use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} , { 'BurntSushi/ripgrep' }},
    config = function()
        require("plugins.telescope")
    end
}

if vim.g.is_win ~= true then
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
end

-- file explorer
use({
    'kyazdani42/nvim-tree.lua',
    config = function()
        require("plugins.nvim-tree")
    end
})

-- quickfix vim-bqf
use {
    "kevinhwang91/nvim-bqf",
    config =  function()
        require("plugins.bqf")
    end,
    ft = { 'qf' }
}

-----------------------------------------------------------
-- Completion , LSP
-----------------------------------------------------------

-- LSP
use({
    'neovim/nvim-lspconfig',
    -- config = function()
    --     require('plugins.lsp')
    -- end,
    requires = {
        { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
        -- { 'williamboman/nvim-lsp-installer' , opt = true, event = "VimEnter" },
    },
})

use({
    'williamboman/nvim-lsp-installer',
    config = function()
        require('plugins.lsp')
    end,
})

-- null-ls with prettier
use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require('plugins.null-ls')
    end,
}

-- lspkind
use {'onsails/lspkind-nvim'}

-- lsp signature
use {
  "ray-x/lsp_signature.nvim",
  config = function()
        require "lsp_signature".setup()
  end
}

-- Completion
use {
    'hrsh7th/nvim-cmp',
    event = "UIEnter",
    opt = true,
    requires = {
        {'hrsh7th/cmp-nvim-lsp', module = "cmp_nvim_lsp", opt = true},
        {'hrsh7th/cmp-buffer', opt = true},
        {'hrsh7th/cmp-path', opt = true},
        {'hrsh7th/cmp-nvim-lua', opt = true},
        {'saadparwaiz1/cmp_luasnip', opt = true}
    },
    config = function() require'plugins.completion'.setup() end
}
use {
    'L3MON4D3/LuaSnip',
    after = "nvim-cmp",
    requires = {{"rafamadriz/friendly-snippets"}},
    config = function() require'plugins.completion'.luasnip() end
}

-- Trouble Diagnostics List
use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
    }
  end
}

-- Miscellaneous

-----------------------------------------------------------
-- Helpers
-----------------------------------------------------------

-- Project Management
use {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

-- which-key
use {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
        require('plugins.whichkey')
    end
}

-- Keep last place on start
use {
    "ethanholz/nvim-lastplace",
    config = function()
        require("nvim-lastplace").setup {
        }
    end
}

-- hop (better and simpler than lightspeed) Need more experimentation
use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    event = "BufRead",
    cmd = {"HopChar2", "HopWord"},
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        -- vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('hop').hint_words()<cr>", {})
        vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })

    end
}

-----------------------------------------------------------
-- UI enhacements
-----------------------------------------------------------

-- colors
use 'folke/tokyonight.nvim'

-- cursorline
use  {'yamatsum/nvim-cursorline'}

-- lualine
use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup()
    end
}

-- gitsign
use {
    'lewis6991/gitsigns.nvim',
    requires = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('gitsigns').setup()
    end
}

-- bufferline
use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    setup = function()
        vim.api.nvim_set_keymap("n", "<Tab>",":BufferLineCycleNext<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<S-Tab>",":BufferLineCyclePrev<CR>", {noremap = true, silent = true})
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
}

-- indent blankline
use { "lukas-reineke/indent-blankline.nvim" }

-- truezen
use {
    "Pocco81/TrueZen.nvim" ,
    config = function()
        local default_opts = { noremap = true, silent = true  }
        vim.api.nvim_set_keymap("n", "<F12>", [[<Cmd>TZAtaraxis<CR>]], default_opts)
    end
}

-----------------------------------------------------------
-- Terminal enhacements
-----------------------------------------------------------

-- toggleterm and floatterm
use {
    "akinsho/toggleterm.nvim" ,
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>tt",":ToggleTerm<CR>", {noremap = true, silent = true})
    end,
    cmd = {"ToggleTerm"},
    keys = {
        { "n", "<leader>tt" },
    },

}

use {
    "voldikss/vim-floaterm",
    setup = function()
        require "plugins.floaterm".setup()
    end,
    -- cmd = "FloatermNew",
    cmd = { "FloatermToggle", "FloatermNew"},
}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

