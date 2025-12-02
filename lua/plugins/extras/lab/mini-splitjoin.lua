return {
    -- mini-spitjoin
    {
        'nvim-mini/mini.splitjoin',
        -- event = "VeryLazy",
        event = "BufReadPre",
        version = '*',
        opts = {
        },
        keys = {
            { "gS" },
        }
    }
}
