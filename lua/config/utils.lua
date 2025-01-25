local M = {}

-- QuickFix window toggle function
function M.QuickFixToggle()
    local quickfix_exists = function()
        for _, win in pairs(vim.fn.getwininfo()) do
            if win.quickfix == 1 then
                return true
            end
        end
        return false
    end

    if quickfix_exists() then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end

-- Visual Selection helper function
-- Not working correctly, using the vimscript version for now
function M.VisualSelection(direction, extra_filter)
    local saved_reg = vim.fn.getreg('"')
    local saved_regtype = vim.fn.getregtype('"')
    vim.cmd('normal! vgvy')

    local pattern = vim.fn.escape(vim.fn.getreg('"'), '\\/.*$^~[]')
    pattern = string.gsub(pattern, "\n$", "")

    if direction == 'replace' then
        vim.cmd('%s/' .. pattern .. '/')
    elseif direction == '' then
        vim.cmd('/' .. pattern)
    end

    vim.fn.setreg('"', saved_reg, saved_regtype)
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