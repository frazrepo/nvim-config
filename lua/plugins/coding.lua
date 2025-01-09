-----------------------------------------------------------
-- Code Helpers - Code Generation
-----------------------------------------------------------
return
{
    -----------------------------------------------------------
    -- Autorename, Autopair, Autotag
    -----------------------------------------------------------
    -- Autorename tags
    {
        'AndrewRadev/tagalong.vim',
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    },

    -- Autotags (see treesitter for activation)
    -- Need to install parser for html /xml :TSInstall html
    {
        'windwp/nvim-ts-autotag',
        ft = {
            "html",
            "xml",
        },
    },

    -----------------------------------------------------------
    -- Text objects
    -----------------------------------------------------------
    {
        'coderifous/textobj-word-column.vim'
    },
    {
        'michaeljsmith/vim-indent-object'
    },
    {
        "wellle/targets.vim",
        event = { "BufReadPost" },
    },
    -----------------------------------------------------------
    -- Emmet configuration file
    -- html/css snippets
    -----------------------------------------------------------
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
            -- vim.g.user_emmet_leader_key = "<C-Z>"
            vim.keymap.set("i", "<C-e>", "<Plug>(emmet-expand-abbr)", {remap = true})
            vim.keymap.set("n", ")e", "<Plug>(emmet-move-next)", {remap = true})
            vim.keymap.set("n", "(e", "<Plug>(emmet-move-prev)", {remap = true})
        end,
    }
}
