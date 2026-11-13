local now = Config.now

now(function()
    -- Configure theme
    vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
    require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        float = {
            transparent = true,
        },
    })

    vim.cmd.colorscheme("catppuccin-nvim")

    -- Configure ui-2
    local ui2 = require("vim._core.ui2")
    ui2.enable({
        enable = true,
        msg = {
            targets = "msg",
        },
    })
end)
