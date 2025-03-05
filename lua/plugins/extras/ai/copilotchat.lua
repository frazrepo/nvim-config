return {
    -- copilot chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cond = FrazVim.extras.ai.engine == "copilot",
        dependencies = {
            -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua    
            { "github/copilot.vim" , cond = FrazVim.extras.ai.engine == "copilot" },
            -- { "zbirenbaum/copilot.lua" , cond = FrazVim.extras.aiengine == "copilot" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        keys = {
            { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
            {
                "<leader>aa",
                function()
                    return require("CopilotChat").toggle()
                end,
                desc = "Toggle (CopilotChat)",
                mode = { "n", "v" },
            },
            {
                "<leader>ax",
                function()
                    return require("CopilotChat").reset()
                end,
                desc = "Clear (CopilotChat)",
                mode = { "n", "v" },
            },
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end,
                desc = "Quick Chat (CopilotChat)",
                mode = { "n", "v" },
            },
            -- Show prompts actions with telescope
            -- { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
        },

        -- build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
        -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
