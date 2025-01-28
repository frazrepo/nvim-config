return {
    -- copilot
    -- requirements node 18+
    -- Mapping default Alt-L to accept,
    {
        "zbirenbaum/copilot.lua",
        enable = false,
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>", 
                    next = "<M-)>",
                    prev = "<M-(>",
                    dismiss = "<C-c>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
            },
        },
    },      
}
