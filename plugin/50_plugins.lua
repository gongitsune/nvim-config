local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

now_if_args(function()
    -- Define hook to update tree-sitter parsers after plugin is updated
    local ts_update = function()
        vim.cmd("TSUpdate")
    end
    Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

    add({
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/stevearc/conform.nvim",
        "https://github.com/saghen/blink.lib",
        "https://github.com/saghen/blink.cmp",
        "https://github.com/zbirenbaum/copilot.lua",
        "https://github.com/copilotlsp-nvim/copilot-lsp",
        "https://github.com/saghen/blink.indent",
    })

    -- Configure tree-sitter
    local languages = {
        "lua",
        "vimdoc",
        "markdown",
    }
    local isnt_installed = function(lang)
        return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
    end
    local to_install = vim.tbl_filter(isnt_installed, languages)
    if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
    end

    -- Enable tree-sitter after opening a file for a target language
    local filetypes = {}
    for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            table.insert(filetypes, ft)
        end
    end
    local ts_start = function(ev)
        vim.treesitter.start(ev.buf)
    end
    Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

    -- lsp setup
    vim.lsp.enable({
        "lua_ls",
        "clangd",
        "basedpyright",
        "ruff",
        "vhdl_ls",
        "speja",
        "tsc",
        "oxlint",
        "jsonls",
    })

    -- Configure conform for code format
    require("conform").setup({
        default_format_opts = {
            -- Allow formatting from LSP server if no dedicated formatter is available
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            cpp = { "clang-format" },
            c = { "clang-format" },
            typescript = { "oxfmt" },
        },
    })
    Config.new_autocmd("BufWritePre", "*", function(args)
        require("conform").format({ bufnr = args.buf })
    end)

    -- blink.nvim for autocomplete and signature help
    local cmp = require("blink.cmp")
    cmp.build():pwait()
    cmp.setup()

    -- Copilot setup
    require("copilot").setup({
        nes = {
            enabled = true,
            keymap = {
                accept_and_goto = "<Leader>p",
                accept = false,
                dismiss = "<Esc>",
            },
        },
        suggestion = {
            auto_trigger = true,
        },
    })
end)

later(function()
    add({
        "https://github.com/lewis6991/gitsigns.nvim",
        "https://github.com/stevearc/overseer.nvim",
    })

    -- Gitsigns setup
    require("gitsigns").setup()

    -- Overseer setup
    require("overseer").setup()
end)
