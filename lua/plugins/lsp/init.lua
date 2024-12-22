-- Discard if provider is coc
if vim.g.lspprovider == 'coc' then return {} end

return {
    -----------------------------------------------------------
    -- Completion , LSP
    -----------------------------------------------------------
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'saghen/blink.cmp'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            require('plugins.lsp')
        end,
    },

    -- blink cmp - ultrafast completor
    { -- Optional
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            -- keymap = { preset = 'default' },
            keymap = { preset = 'super-tab' },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
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
