local now = Config.now

now(function()
    vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
    require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        float = {
            transparent = true,
        },
    })

    vim.cmd.colorscheme("catppuccin-nvim")
end)
