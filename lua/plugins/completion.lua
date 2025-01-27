return {
    -----------------------------------------------------------
    -- Completion blink
    -----------------------------------------------------------
	{ -- Optional
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		-- optional: provides snippets for the snippet source
		dependencies = {
			 "rafamadriz/friendly-snippets",
			 "giuxtaposition/blink-cmp-copilot",
		},
		version = "*",
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			-- keymap = { preset = 'default' },
			keymap = { preset = "super-tab" },

			appearance = {
				-- use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "snippets", "buffer", "copilot"},
				-- For copilot
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
				-- Disable cmdline completion
				cmdline = {},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				  },
				trigger = { 
					show_on_insert_on_trigger_character = false,
				}
			}
		},
	},
}
