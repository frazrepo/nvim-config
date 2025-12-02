return {
    -----------------------------------------------------------
    -- Completion blink
    -----------------------------------------------------------
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*",
		opts = {
			snippets = {
				preset = "default",
			},

			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "enter" },
			-- Choosing enter for preset here so we can complete copilot with tab

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			sources = {
				 default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
					["<Right>"] = false,
					["<Left>"] = false,
				},
				completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function(ctx)
					return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
				},
			},
			signature = {
				enabled = true,
			},
			completion = {
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = true,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
