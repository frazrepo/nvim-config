-----------------------------------------------------------
-- null-ls configuration
-- Plugin: null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-----------------------------------------------------------

-- Formatting config
-- Needs to install each binary associated with each formatter : prettier, sqlformat, sqllua, ...
local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "md",
      "txt",
    },
  }),
  null_ls.builtins.formatting.stylua.with({
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),
  null_ls.builtins.formatting.sqlformat,
}

local map = vim.api.nvim_set_keymap
require("null-ls").setup({
  sources = sources,
  on_attach = function(client)
    map('n', ',f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', {noremap =true, silent = true})
    
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_create_user_command(
      'Format', 
      function()
        vim.lsp.buf.format { async = true }
      end,
      { desc = 'Format current buffer with LSP' }
    )

    if client.server_capabilities.document_formatting then
            -- Todo when installing stylelua, sqlformat and prettier
       -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
