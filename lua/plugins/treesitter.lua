-----------------------------------------------------------
-- Floaterm configuration file
-- Plugin: nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-----------------------------------------------------------

require('nvim-treesitter.configs').setup {
  -- ensure_installed = "maintained",
  ensure_installed = {
      "lua",
  },
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
    filetypes = { "html" , "xml" },
  }
}

