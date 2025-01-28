return {
    -- copilot chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        -- enable = FrazUtil.extras.aiengine == "copilot",
        dependencies = {
            -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua    
            -- { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        -- build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
        -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
