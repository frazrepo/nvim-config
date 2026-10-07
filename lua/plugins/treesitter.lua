-----------------------------------------------------------
-- Plugin: nvim-treesitter (main branch, Neovim >= 0.12)
-- https://github.com/nvim-treesitter/nvim-treesitter
-- Requirements: tree-sitter CLI (>= 0.25) and a C compiler
-- Check with :checkhealth nvim-treesitter
-----------------------------------------------------------

-- treesitter interface : syntax highlighter
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- main branch does not support lazy-loading
		build = ":TSUpdate",
        config = function()
          -- ensure these language parsers are installed (async)
          -- :TSInstall c_sharp
          require("nvim-treesitter").install({
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "lua",
            "vim",
            "dockerfile",
            "gitignore",
          })

          -- enable syntax highlighting and indentation for every filetype with a parser
          vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("frazvim_treesitter", { clear = true }),
            callback = function(event)
              if not pcall(vim.treesitter.start, event.buf) then
                return
              end
              local lang = vim.treesitter.language.get_lang(event.match)
              if lang and vim.treesitter.query.get(lang, "indents") then
                vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end
            end,
          })

          -- Incremental selection: see <C-space> mappings in lua/config/keymaps.lua (built-in an/in)
        end,
      },
      -- TreeSitter context commentstring (used by the built-in gc commenting)
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = "VeryLazy",
        opts = { enable_autocmd = false },
        config = function(_, opts)
          require("ts_context_commentstring").setup(opts)
          local get_option = vim.filetype.get_option
          ---@diagnostic disable-next-line: duplicate-set-field
          vim.filetype.get_option = function(filetype, option)
            return option == "commentstring"
              and require("ts_context_commentstring.internal").calculate_commentstring()
              or get_option(filetype, option)
          end
        end,
      },

      -- Textobjects queries (used by mini.ai for af/if, ac/ic, ao/io)
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = "main",
        event = "VeryLazy",
      },

      -- Autotags  and Autorename tags
      -- Need to install TreeSitter parser for html /xml :TSInstall html
      {
        'windwp/nvim-ts-autotag',
        -- event = "VeryLazy",
        event = "BufRead",
        config = function()
          require('nvim-ts-autotag').setup({
            opts = {
              -- Defaults
              enable_close = true, -- Auto close tags
              enable_rename = true, -- Auto rename pairs of tags
              enable_close_on_slash = true -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            -- per_filetype = {
              --   ["html"] = {
                --     enable_close = false
                --   }
                -- }
              })
            end
          },
        }
