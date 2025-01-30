-----------------------------------------------------------
-- Search Replace
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

			-- <leader<R> : Project wide find and replace. 
			-- It's similar to <leader>r but applies to all matches across all files.

			vim.cmd([[
				nnoremap <Leader>R
				\ :let @s=expand('<cword>')<CR>
				\ :Grepper -cword -noprompt<CR>
				\ :cfdo %s/<C-r>s//g \| update
				\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
			]])

			-- Visual Selection Variant
			vim.cmd([[
				xmap <Leader>R
				\ "sy
				\ :Grepper -cword -noprompt<CR>
				\ :cfdo %s/<C-r>s//g \| update
				\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
			]])

			-- Custom commands
			-- https://github.com/mhinz/vim-grepper/wiki/example-configurations-and-mappings
			vim.cmd([[
				command! Todo :Grepper -tool git -query '\(TODO\|FIXME\)'
			]])
		end,
		keys = {
			{ "<Leader>R" , desc ="Search Replace Globally (cdo)", mode = {"n","x"} },
			{ "<Leader>*", "<Cmd>Grepper -cword -noprompt<Cr>", desc = "Search word under cursor (grepper)" },
			{ "<Leader>/", "<Cmd>Grepper<Cr>", desc = "Search globally (grepper)" },
			{ "<Leader>G", "<Cmd>Grepper -buffers<Cr>", desc = "Search in all open Buffers (grepper)" },
			{ "<Leader>g", "<Cmd>Grepper -buffer<Cr>", desc = "Search in current buffer (grepper)" },
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
            {
                "<leader>sa",
                "<cmd> lua require('grug-far').open({ engine = 'astgrep' })<cr>",
                mode = { "n", "v" },
                desc = "Search and Replace (astgrep)",
            },
        },
	},	
}
