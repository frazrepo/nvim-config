-----------------------------------------------------------
-- Editor features
-----------------------------------------------------------
return {
	-- Conform
	{
		"stevearc/conform.nvim",
		-- event = "BufReadPre",
		-- cmd = "ConFormat",
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
					xml = { "xmlformatter" },
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
				default_format_opts = {
					lsp_format = "fallback",
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

			-- Mappings
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (conform)" })

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
