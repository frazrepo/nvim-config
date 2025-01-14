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
        ft = {
            "html",
            "xml",
            "jsx",
            "tsx",
            "javascriptreact",
            "typescriptreact",
        },
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = { "InsertEnter" },
        opts = {}
    },

    -----------------------------------------------------------
    -- Text objects
    -----------------------------------------------------------
    {
        'coderifous/textobj-word-column.vim',
        event = { "BufReadPost" },
    },
    {
        'michaeljsmith/vim-indent-object',
        event = { "BufReadPost" },
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
