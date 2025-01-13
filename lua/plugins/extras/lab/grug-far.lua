
return {
	-- grug-far Search and Replace
	{
        "MagicDuck/grug-far.nvim",
        opts = {
            headerMaxWidth = 80,
        },
        cmd = "GrugFar",
        keys = {
            {
                --ripgrep not working yet on windows
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
            {
                "<leader>sa",
                "<cmd> lua require('grug-far').open({ engine = 'astgrep' })<cr>",
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
	},
}
