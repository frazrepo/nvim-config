
return {
	-- Added on 20250103
	-- grug-far Search and Replace
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		config = function()
			require("grug-far").setup({
				windowsCreationCommand = "botright vsplit %",
				-- options, see Configuration section below
				-- there are no required options atm
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
	},
}
