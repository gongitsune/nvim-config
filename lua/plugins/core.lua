return {
    {
        'stevearc/resession.nvim',
        opts = {
            extensions = {
                oil = {}
            }
        }
    },
    {
        'mrjones2014/smart-splits.nvim',
        opts = {
            ignored_filetypes = { "nofile", "quickfix", "qf", "prompt", "oil" },
            ignored_buftypes = { "nofile" },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "User CustomFIle",
        opts = {
            check_ts = true,
            ts_config = { java = false },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("utils.nerd_icons")

            ---@module "which-key"
            ---@type wk.Opts
            return {
                preset = "modern",
                icons = {
                    rules = {
                        { pattern = "close",    icon = icons.BufferClose, color = "red" },
                        { pattern = "find",     icon = icons.Search,      color = "yellow" },
                        { pattern = "packages", icon = icons.Package,     color = "cyan" },
                        { pattern = "lsp",      icon = icons.ActiveLSP,   color = "green" },
                        { pattern = "ui/ux",    icon = icons.Window,      color = "cyan" },
                        { pattern = "buffer",   icon = icons.Tab,         color = "cyan" },
                        { pattern = "debugger", icon = icons.Debugger,    color = "orange" },
                        { pattern = "git",      icon = icons.Git,         color = "blue" },
                        { pattern = "session",  icon = icons.Session,     color = "blue" },
                        { pattern = "terminal", icon = icons.Terminal,    color = "green" },
                    }
                },
                disable = {
                    ft = {
                        "TelescopePrompt",
                    }
                },
            }
        end,
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
    },
}
