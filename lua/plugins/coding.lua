-----------------------------------------------------------
-- Code Helpers - Code Generation
-----------------------------------------------------------
return
{
    -----------------------------------------------------------
    -- Autorename, Autopair, Autotag
    -----------------------------------------------------------
    -- Autorename tags
    {
        'AndrewRadev/tagalong.vim',
        ft = {
            "html",
            "xml",
            "jsx",
            "tsx",
            "javascriptreact",
            "typescriptreact",
        },
    },
    -- auto pairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
    },
    -----------------------------------------------------------
    -- Text objects
    -----------------------------------------------------------
    {
        'coderifous/textobj-word-column.vim',
        event = { "BufReadPost" },
    },
    {
        'michaeljsmith/vim-indent-object',
        event = { "BufReadPost" },
    },
    {
        'echasnovski/mini.ai',
        version = '*',
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
                    d = { "%f[%d]%d+" }, -- digits
                    e = { -- Word with case
                        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                        "^().*()$",
                    },
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line('$'),
                            col = math.max(vim.fn.getline('$'):len(), 1)
                        }
                        return { from = from, to = to, vis_mode = 'V' }
                    end, -- buffer
                    u = ai.gen_spec.function_call(), -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                    i = function()
                        local cursor_line = vim.fn.line('.')  -- Current line number
                        local cursor_indent = vim.fn.indent(cursor_line)  -- Current line's indentation level

                        local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)  -- Get all buffer lines
                        local total_lines = #buf_lines

                        -- Find the start and end of the indent block
                        local start_line, end_line = cursor_line, cursor_line

                        -- Look upwards
                        while start_line > 1 and vim.fn.indent(start_line - 1) >= cursor_indent do
                            start_line = start_line - 1
                        end

                        -- Look downwards
                        while end_line < total_lines and vim.fn.indent(end_line + 1) >= cursor_indent do
                            end_line = end_line + 1
                        end

                        -- Return the range
                        return {
                            from = { line = start_line, col = 1 },
                            to = { line = end_line, col = vim.fn.col({ end_line, '$' }) },
                        }
                    end, --indent
                },
            }
        end,
    },
    -----------------------------------------------------------
    -- Emmet configuration file
    -- html/css snippets
    -----------------------------------------------------------
    {
        "mattn/emmet-vim",
        ft = {
            "html",
            "css",
            "typescript",
            "typescriptreact",
            "javascriptreact",
            "javascript",
        },
        config = function()
            -- vim.g.user_emmet_leader_key = "<C-Z>"
            vim.keymap.set("i", "<C-e>", "<Plug>(emmet-expand-abbr)", {remap = true})
            vim.keymap.set("n", ")e", "<Plug>(emmet-move-next)", {remap = true})
            vim.keymap.set("n", "(e", "<Plug>(emmet-move-prev)", {remap = true})
        end,
    }
}
