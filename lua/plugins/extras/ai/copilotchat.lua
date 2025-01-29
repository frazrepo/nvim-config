return {
    -- copilot chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        -- enabled = false,
        cond = FrazVim.extras.ai.engine == "copilot",
        dependencies = {
            -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua    
            { "github/copilot.vim" , cond = FrazVim.extras.ai.engine == "copilot" },
            -- { "zbirenbaum/copilot.lua" , cond = FrazVim.extras.aiengine == "copilot" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        -- build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
        -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
