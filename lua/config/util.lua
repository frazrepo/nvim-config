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
}

--Define a setup function Helpers
M.setup = function()
    _G.FrazVim = M
    -- check if mac the set extras.ai.engine as codeium
    if vim.fn.has("mac") == 1 then
        M.extras.ai.engine = "codeium"
    else
        M.extras.ai.engine = "copilot"
    end
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


-- root - get root dir based on some pattern
-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile' }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

function M.root()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then
      -- return cwd in neovim
      return path
    end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end
  return root
end

return M
