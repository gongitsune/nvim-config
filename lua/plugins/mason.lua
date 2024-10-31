return {
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_uninstalled = "✗",
                    package_pending = "⟳",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)

            -- Load the lspconfig and nvim-dap plugins
            for _, plugin in ipairs { "mason-lspconfig", "mason-nvim-dap" } do
                pcall(require, plugin)
            end
        end,
    },
}
