return {
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
            require('plugins.lsp.lsp-zero')
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
            require('plugins.lsp.null-ls')
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
}