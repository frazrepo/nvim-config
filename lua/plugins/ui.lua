-----------------------------------------------------------
-- UI enhacements
-----------------------------------------------------------
return {

-- mini icons
{
    'nvim-mini/mini.icons',
    version = false,
    config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
    end
}, 

-- lualine
{
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    opts = {}
},

-- gitsign
{
    'lewis6991/gitsigns.nvim',
    -- event : LazyFile = { "BufReadPost", "BufWritePost", "BufNewFile" } 
    event = {"BufReadPost", "BufWritePost", "BufNewFile"},
    dependencies = {{'nvim-lua/plenary.nvim'}},
    keys = {{"<leader>gb"}, {'<leader>guw'}, {'<leader>guL'}, {'<leader>guv'}},
    config = function()
        require('gitsigns').setup()
        vim.keymap.set('n', '<leader>gb', require("gitsigns").blame, {
            desc = 'git blame'
        })
        -- Highlight word diff
        vim.keymap.set('n', '<leader>guw', require('gitsigns').toggle_word_diff, {
            desc = 'Toggle word diff'
        })
        -- Highlight added lines.
        vim.keymap.set('n', '<leader>gul', require('gitsigns').toggle_linehl, {
            desc = 'Toggle line highlight'
        })
        -- Preview hunk inline
        vim.keymap.set('n', '<leader>guv', require('gitsigns').preview_hunk_inline, {
            desc = 'Toggle preview inline'
        })
    end
},

-- bufferline
{
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    keys = {{
        "<leader>bp",
        "<Cmd>BufferLineTogglePin<CR>",
        desc = "Toggle Pin"
    }, {
        "<leader>bP",
        "<Cmd>BufferLineGroupClose ungrouped<CR>",
        desc = "Delete Non-Pinned Buffers"
    }, {
        "<leader>br",
        "<Cmd>BufferLineCloseRight<CR>",
        desc = "Delete Buffers to the Right"
    }, {
        "<leader>bl",
        "<Cmd>BufferLineCloseLeft<CR>",
        desc = "Delete Buffers to the Left"
    }, {
        "<S-Tab>",
        "<cmd>BufferLineCyclePrev<cr>",
        desc = "Prev Buffer"
    }, {
        "<Tab>",
        "<cmd>BufferLineCycleNext<cr>",
        desc = "Next Buffer"
    }, {
        "(b",
        "<cmd>BufferLineCyclePrev<cr>",
        desc = "Prev Buffer"
    }, {
        ")b",
        "<cmd>BufferLineCycleNext<cr>",
        desc = "Next Buffer"
    }, {
        "<b",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "Move buffer prev"
    }, {
        ">b",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "Move buffer next"
    }},
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            offsets = {{
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left"
            }}
        }
    },
    config = function(_, opts)
        require('bufferline').setup(opts)
    end
}, 

-- snack dashboard
{
    "folke/snacks.nvim",
    opts = {
        dashboard = {
            width = 60,
            row = nil, -- dashboard position. nil for center
            col = nil, -- dashboard position. nil for center
            pane_gap = 4, -- empty columns between vertical panes
            autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
            -- These settings are used by some built-in sections
            preset = {
                -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                pick = nil,
                -- Used by the `keys` section to show keymaps.
                -- Set your custom keymaps here.
                -- When using a function, the `items` argument are the default keymaps.
                keys = {{
                    icon = " ",
                    key = "f",
                    desc = "Find File",
                    action = ":lua Snacks.dashboard.pick('files')"
                }, {
                    icon = " ",
                    key = "n",
                    desc = "New File",
                    action = ":ene | startinsert"
                }, {
                    icon = " ",
                    key = "g",
                    desc = "Find Text",
                    action = ":lua Snacks.dashboard.pick('live_grep')"
                }, {
                    icon = " ",
                    key = "r",
                    desc = "Recent Files",
                    action = ":lua Snacks.dashboard.pick('oldfiles')"
                }, {
                    icon = " ",
                    key = "p",
                    desc = "Projects",
                    action = ":lua Snacks.picker.projects()"
                }, {
                    icon = " ",
                    key = "c",
                    desc = "Config",
                    action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"
                }, {
                    icon = "󰒲 ",
                    key = "l",
                    desc = "Lazy",
                    action = ":Lazy",
                    enabled = package.loaded.lazy ~= nil
                }, {
                    icon = " ",
                    key = "q",
                    desc = "Quit",
                    action = ":qa"
                }},

                -- To generate this text : https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=FRAZ
                header = [[
            ]]
            },
            -- item field formatters
            formats = {
                icon = function(item)
                    if item.file and item.icon == "file" or item.icon == "directory" then
                        return M.icon(item.file, item.icon)
                    end
                    return {
                        item.icon,
                        width = 2,
                        hl = "icon"
                    }
                end,
                footer = {
                    "%s",
                    align = "center"
                },
                header = {
                    "%s",
                    align = "center"
                },
                file = function(item, ctx)
                    local fname = vim.fn.fnamemodify(item.file, ":~")
                    fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                    if #fname > ctx.width then
                        local dir = vim.fn.fnamemodify(fname, ":h")
                        local file = vim.fn.fnamemodify(fname, ":t")
                        if dir and file then
                            file = file:sub(-(ctx.width - #dir - 2))
                            fname = dir .. "/…" .. file
                        end
                    end
                    local dir, file = fname:match("^(.*)/(.+)$")
                    return dir and {{
                        dir .. "/",
                        hl = "dir"
                    }, {
                        file,
                        hl = "file"
                    }} or {{
                        fname,
                        hl = "file"
                    }}
                end
            },
            sections = {{
                section = "header"
            }, {
                section = "keys",
                gap = 1,
                padding = 1
            }, {
                section = "startup"
            }}
        }
    }
},

-- nvim ufo
{
    -- Usage : za to toggle
    -- zr to reveal all
    -- zm to hide all
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "UIEnter", -- needed for folds to load in time and comments being closed
    keys = {{
        "<leader>if",
        vim.cmd.UfoInspect,
        desc = " Fold info"
    }, {
        "zm",
        function()
            require("ufo").closeAllFolds()
        end,
        desc = "󱃄 Close all folds"
    }, {
        "zr",
        function()
            require("ufo").openFoldsExceptKinds {"comment", "imports"}
        end,
        desc = "󱃄 Open regular folds"
    }},
    init = function()
        -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
        -- auto-closing them after leaving insert mode, however ufo does not seem to
        -- have equivalents for `zr` and `zm` because there is no saved fold level.
        -- Consequently, the vim-internal fold levels need to be disabled by setting
        -- them to 99.
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
    end,
    opts = {
        -- when opening the buffer, close these fold kinds
        close_fold_kinds_for_ft = {
            default = {"imports", "comment"},
            json = {"array"},
            markdown = {}, -- avoid everything becoming folded
            toml = {}
            -- use `:UfoInspect` to get see available fold kinds
        },
        open_fold_hl_timeout = 800,
        provider_selector = function(_bufnr, ft, _buftype)
            -- ufo accepts only two kinds as priority, see https://github.com/kevinhwang91/nvim-ufo/issues/256
            local lspWithOutFolding = {"markdown", "zsh", "bash", "css", "python", "json"}
            if vim.tbl_contains(lspWithOutFolding, ft) then
                return {"treesitter", "indent"}
            end
            return {"lsp", "indent"}
        end,
        -- show folds with number of folded lines instead of just the icon
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local hlgroup = "NonText"
            local icon = ""
            local newVirtText = {}
            local suffix = ("  %s %d"):format(icon, endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, hlgroup})
            return newVirtText
        end
    }
}
}
