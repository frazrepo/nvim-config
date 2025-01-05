-----------------------------------------------------------
-- Emmet configuration file
-- html/css snippets
-----------------------------------------------------------
return {
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
