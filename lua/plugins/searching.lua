-----------------------------------------------------------
-- Search Replace
-----------------------------------------------------------

return {
	-- vim-grepper
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
			{ "<Leader>R" , desc ="Search Replace Globally"},
			{ "<Leader>*", "<Cmd>Grepper -cword -noprompt<Cr>", desc = "Grepper Word Under Cursor" },
			{ "<Leader>/", "<Cmd>Grepper<Cr>", desc = "Grepper" },
			{ "<Leader>G", "<Cmd>Grepper -buffers<Cr>", desc = "Grepper in all Buffers" },
			{ "<Leader>g", "<Cmd>Grepper -buffer<Cr>", desc = "Grepper in current buffer" },
			{ "gx", "<Plug>(GrepperOperator)", desc = "Grepper Operator" },
			{ "gx", "<Plug>(GrepperOperator)", desc = "Grepper Operator", mode = "x" },
		}
	},
    -- ripgrep integration
    {
        'BurntSushi/ripgrep'
    },


}
