return {
    {
        "nvim-tree/nvim-web-devicons",
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "Oil" },
        ---@module "oil"
        ---@type oil.SetupOpts
        opts = {}
    },
    {
        "rcarriga/nvim-notify",
        init = function()
            require("utils").load_plugin_with_func("nvim-notify", vim, "notify")
        end,
        opts = {
            background_colour = "#000000",
        },
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
        opts = { user_default_options = { names = false } }
    },
    {
        'stevearc/dressing.nvim',
        init = function()
            require("utils").load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" })
        end,
        opts = {
            input = { default_prompt = "➤ " },
            select = { backend = { "telescope", "builtin" } },
        },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
                delay = 10,
                duration = 100,
                exclude_filetypes = {
                    help = true,
                    startify = true,
                    aerial = true,
                    alpha = true,
                    dashboard = true,
                    lazy = true,
                    neogitstatus = true,
                    NvimTree = true,
                    neo = true,
                    Trouble = true,
                }
            },
        }
    },
}
