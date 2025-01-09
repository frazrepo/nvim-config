return {
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

				-- Do not format on save
				-- format_after_save = function()
				-- 	if not vim.g.autoformat then
				-- 		return
				-- 	else
				-- 		if vim.bo.filetype == "ps1" then
				-- 			vim.lsp.buf.format()
				-- 			return
				-- 		end
				-- 		return { lsp_format = "fallback" }
				-- 	end
				-- end,

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
}
