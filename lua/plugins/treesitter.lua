-----------------------------------------------------------
-- Plugin: nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-----------------------------------------------------------

require('nvim-treesitter.configs').setup {
  -- ensure_installed = "maintained",
  -- Additional
  -- :TSInstall html
  -- :TSInstall c_sharp
  -- Check with :TSInstallInfo
  ensure_installed = {
      "lua",
  },
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = false
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
    filetypes = { "html" , "xml" },
  },
   textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
  }
}
