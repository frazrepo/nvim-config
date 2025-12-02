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
-- Search Replace Globally : <leader>sr/sa (grug-far)  or <leader><leader>x (cfdo)
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
        cmd = {"Grepper"},
		keys = {
          { "gf", "<Plug>(GrepperOperator)", desc = "Grepper Search operator", mode = {"n","x"} },
          { "<leader>s;", "<cmd>Grepper -buffer<cr>", desc = "Grepper Search Buffer", mode = {"n","x"} },
		}
	},
	-- grug-far Search and Replace
  -- mapping ,o/,c to open/close
  -- ,q : send search result to quickfix
	{
        "MagicDuck/grug-far.nvim",
        opts = {
            headerMaxWidth = 80,
        },
        cmd = "GrugFar",
        keys = {
            {
                -- Requires the latest version of ripgrep
                "<leader>rg",
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
                desc = "Search and Replace (rg)",
            },
            {
                -- Requires the latest version of ast-grep
                "<leader>ra",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        engine = "astgrep",
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,

                mode = { "n", "v" },
                desc = "Search and Replace (ast)",
            },
            {
                -- Requires the latest version of ripgrep
                "<leader>rb",
                function()
                    local grug = require("grug-far")
                    grug.open({
                        transient = true,
                        prefills = {
                             paths = vim.fn.expand("%")
                        },
                    })
                end,

                mode = { "n", "v" },
                desc = "Search and Replace in buffer(rg)",
            },
            {
                -- Requires the latest version of ripgrep
                "<leader>rv",
                function()
                    local grug = require("grug-far")
                    grug.with_visual_selection({
                        transient = true,
                        prefills = {
                             paths = vim.fn.expand("%")
                        },
                    })
                end,

                mode = { "v" },
                desc = "Search and Replace selection in buffer (rg)",
            },
        },
	},
}
