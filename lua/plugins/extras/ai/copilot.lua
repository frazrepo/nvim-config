return {
    -- copilot
    -- requirements node 18+
    -- Mapping default Alt-L to accept,
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = false,
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>", 
                    next = "<M-n>",
                    prev = "<M-p>",
                    dismiss = "<C-c>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
            },
        },
    },
    {
        "giuxtaposition/blink-cmp-copilot",
    }
      
}
