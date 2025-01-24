return {
    -- copilot
    -- requirements node 18+
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = false, -- handled by nvim-cmp / blink.cmp
                    next = "<M-)>",
                    prev = "<M-(>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
            },
        },
    },
    -- copilot chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        -- build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
        -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
