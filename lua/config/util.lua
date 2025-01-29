-----------------------------------------------------------
-- Global Utilities Helpers
-- FrazVim (_G.FrazVim = require('config.util'))
-----------------------------------------------------------
local M = {}

-- Define a table here for extras plugins activation
M.extras = {
    ai = {
        -- engine = "codeium",
        engine = "copilot",
    },
    lang = {
        powershell = false,
    }
}

--Define a setup function Helpers
M.setup = function()
end

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

-- Clear search highlights and stop snippet
function M.ClearSearchHLAndStopSnippet()
    vim.cmd('noh')
    if (vim.snippet) then
      vim.snippet.stop()
    end
    return "<esc>"
end

-- Clean extra spaces
function M.CleanExtraSpaces()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg('/')
    vim.cmd('silent! %s/\\s\\+$//e')
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end

-- Put visual selection in search register
function M.VisualSelection(direction, extra_filter)
    local saved_reg = vim.fn.getreg('"')
    vim.cmd("normal! vgvy")

    local pattern = vim.fn.escape(vim.fn.getreg('"'), "\\/.*'$^~[]")
    pattern = vim.fn.substitute(pattern, "\n$", "", "")

    if direction == 'replace' then
        vim.fn.feedkeys(":" .. "%s" .. '/'.. pattern .. '/')
    end

    vim.fn.setreg('/', pattern)
    vim.fn.setreg('"', saved_reg)
end

-- Execute macro over visual range
function M.ExecuteMacroOverVisualRange()
    print("@" .. vim.fn.getcmdline())
    vim.cmd(":'<,'>normal @" .. vim.fn.nr2char(vim.fn.getchar()))
end

-- Sort selected lines by width
function M.SortLinesByWidth(firstline, lastline)
    vim.cmd(firstline .. "," .. lastline .. 's/^\\(.*\\)$/\\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/')
    vim.cmd(firstline .. "," .. lastline .. 'sort n')
    vim.cmd(firstline .. "," .. lastline .. 's/^\\d\\+\\s//')
end

return M
