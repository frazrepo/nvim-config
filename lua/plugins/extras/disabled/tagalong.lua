return {
    -----------------------------------------------------------
    -- Autorename, Autopair, Autotag
    -----------------------------------------------------------
    -- Autorename tags
    -- Use autotag for now to see if it is sufficient
    {
        -- Work with , c (change operator), v (visual operator), or insert mode only
        'AndrewRadev/tagalong.vim',
        enabled = false,
        ft = {
            "html",
            "xml",
            "jsx",
            "tsx",
            "javascriptreact",
            "typescriptreact",
        },
    },
}
