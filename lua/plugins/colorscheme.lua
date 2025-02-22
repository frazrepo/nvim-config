-----------------------------------------------------------
-- ColorScheme
-----------------------------------------------------------
return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        enabled = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = { style = "moon" },
        -- enabled = false,
        config = function()
            -- load the colorscheme here
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    -- catppuccin
    {
      "catppuccin/nvim",
      lazy = false,
      name = "catppuccin",
      opts = {
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          fzf = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          snacks = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      },
      specs = {
        {
          "akinsho/bufferline.nvim",
          optional = true,
          opts = function(_, opts)
            if (vim.g.colors_name or ""):find("catppuccin") then
              opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
            end
          end,
        },
      },
      config = function(_,opts)
        -- load the colorscheme here
        vim.cmd.colorscheme("catppuccin")
      end,
    },
  }
