-----------------------------------------------------------
-- Emmet configuration file
-----------------------------------------------------------
local M = {}

M.setup = function()
    -- vim.g.user_emmet_leader_key = "<C-Z>"
    vim.cmd [[
        imap <C-e> <Plug>(emmet-expand-abbr)
        nmap )e <Plug>(emmet-move-next)
        nmap (e <Plug>(emmet-move-prev)
    ]]
end

return M
