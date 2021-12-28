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
  null_ls.builtins.formatting.sqlformat
}
require("null-ls").setup({
  sources = sources,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
            -- Todo when installing stylelua and prettier
       -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
