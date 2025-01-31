-----------------------------------------------------------
-- Search Replace
-- Common workflow
-- LOCAL
-- Search in local buffer : <leader>;
-- Search visual selection in buffer : *
-- Search and Replace in local buffer
--  <leader>ss
--  <leader>sR  (if search register is not empty)
--  <leader>r to replace visual selection
-- GLOBAL
-- Search Globally : <leader>sg (livegrep) or C-F, <leader>sw (for word or selection)
-- Search Replace Globally : <leader>sr (grug-far)  or <leader><leader>x (cfdo)
-----------------------------------------------------------

return {
	-- vim-grepper
    -- Need to install ripgrep command
	{
		"mhinz/vim-grepper",
		config = function()
			vim.g.grepper = {
				tools = { "rg", "git" },
				rg = {
					grepprg = "rg -H --no-heading --vimgrep --hidden",
				},
			}
		end,
		keys = {
          { "gf", "<Plug>(GrepperOperator)", desc = "Grepper Search operator", mode = {"n","x"} },
		}
	},
	-- grug-far Search and Replace
	{
        "MagicDuck/grug-far.nvim",
        opts = {
            headerMaxWidth = 80,
        },
        cmd = "GrugFar",
        keys = {
            {
                -- Requires the latest version of ripgrep
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
                desc = "Search and Replace (ripgrep)",
            },
        },
	},	
}
