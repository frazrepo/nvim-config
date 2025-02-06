return {
 "NeogitOrg/neogit",
 cmd = "Neogit",
 config = function()
  require("neogit").setup({
   kind = "split", -- opens neogit in a split 
   signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
   },
   integrations = { diffview = true }, -- adds integration with diffview.nvim

  })
 end,
 keys= {
  { "<leader>gn", "<cmd>Neogit<CR>", desc = "Neogit" },
 }
}
