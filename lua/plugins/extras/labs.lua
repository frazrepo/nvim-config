-- or to disable to file
-- if true then return {} end
-- Moves config to extras.lua when validated

return {
	-- Added on 20250103
	-- Scratch buffer
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
		},
	},

	-- Added on 20250103
	-- Formatter
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		config = function()
			vim.g.autoformat = true
			require("conform").setup({
				formatters_by_ft = {
					bicep = { "bicep" },
					css = { "prettier" },
					go = { "goimports_reviser", "gofmt", "golines" },
					html = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					lua = { "stylua" },
					markdown = { "prettier" },
					nix = { "nixfmt" },
					rust = { "rustfmt" },
					scss = { "prettier" },
					sh = { "shfmt" },
					templ = { "templ" },
					toml = { "taplo" },
					yaml = { "prettier" },
				},

				format_after_save = function()
					if not vim.g.autoformat then
						return
					else
						if vim.bo.filetype == "ps1" then
							vim.lsp.buf.format()
							return
						end
						return { lsp_format = "fallback" }
					end
				end,

				formatters = {
					goimports_reviser = {
						command = "goimports-reviser",
						args = { "-output", "stdout", "$FILENAME" },
					},
				},
			})

			-- Override bicep's default indent size
			require("conform").formatters.bicep = {
				args = { "format", "--stdout", "$FILENAME", "--indent-size", "4" },
			}

			-- Override prettier's default indent type
			require("conform").formatters.prettier = {
				prepend_args = { "--tab-width", "4" },
			}
		end,
	},

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

	-- splitjoin
	-- mapping conflict with <leader>s , sql buffer
	-- kk : toggle, kj : join, ks : split
	{
		"Wansmer/treesj",
		keys = { "<space>kk", "<space>kj", "<space>ks" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
			-- For use default preset and it work with dot
			vim.keymap.set("n", "<leader>kk", require("treesj").toggle, { silent = false, desc = "SplitJoin Toggle" })
			vim.keymap.set("n", "<leader>kj", require("treesj").join, { desc = "SplitJoin Join" })
			vim.keymap.set("n", "<leader>ks", require("treesj").split, { desc = "SplitJoin Split" })
		end,
	},
}
