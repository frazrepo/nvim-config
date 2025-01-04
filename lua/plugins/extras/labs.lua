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

	-- Added on 20250104
	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			-- TODO: Find a nice mapping for linting
			-- vim.keymap.set("n", "<leader>l", function()
			-- 	lint.try_lint()
			-- end, { desc = "Trigger linting for current file" })

			-- Create a command `:Lint`
			vim.api.nvim_create_user_command("Lint", function()
				lint.try_lint()
			end, { desc = "Lint current buffer" })
		end,
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
					json = { "prettier" },
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

			-- TODO : Find a non conflicting mapping
			-- vim.keymap.set({ "n", "v" }, ")f", function()
			-- 	conform.format({
			-- 		lsp_fallback = true,
			-- 		async = false,
			-- 		timeout_ms = 1000,
			-- 	})
			-- end, { desc = "Format file or range (in visual mode)" })

			-- Create a command `:ConFormat`
			vim.api.nvim_create_user_command("ConFormat", function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format current buffer with conform" })
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
