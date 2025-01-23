
local M = {}

-- QuickFix window toggle function
local quick_fix_open = false
function M.QuickFixToggle()
    if quick_fix_open then
        vim.cmd("cclose")
        quick_fix_open = false
    else
        vim.cmd("copen")
        quick_fix_open = true
    end
end

-- Visual Selection helper function
function M.VisualSelection(direction, extra_filter)
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! vgvy')
    
    local pattern = vim.fn.escape(vim.fn.getreg('"'), '\\/.*$^~[]')
    pattern = string.gsub(pattern, "\n$", "")
    
    if direction == 'b' then
        vim.cmd('normal! ?' .. pattern .. '^M')
    elseif direction == 'replace' then
        vim.cmd('%s/' .. pattern .. '/')
    elseif direction == '' then
        vim.cmd('/' .. pattern)
    end
    
    vim.fn.setreg('"', saved_reg)
end

-- Clear search highlights and stop snippet
function M.ClearSearchHLAndStopSnippet()
    vim.cmd('noh')
    if (vim.snippet) then
      vim.snippet.stop()
    end
    return "<esc>"
end

return M