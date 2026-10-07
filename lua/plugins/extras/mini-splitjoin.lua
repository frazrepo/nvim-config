-- Split and join arguments, lists, and other structures.
-- Toggle between single-line and multi-line forms with `gS`.
-- Works with function args, tables, arrays, imports, etc.
return {
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