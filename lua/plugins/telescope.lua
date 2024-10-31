return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    },
    cmd = "Telescope",
    opts = function()
        local actions = require "telescope.actions"
        local icons = require "utils.nerd_icons"
        return {
            defaults = {
                git_worktrees = vim.g.git_worktrees,
                prompt_prefix = icons.Selected .. " ",
                selection_caret = icons.Selected .. " ",
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = false },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                    n = { q = actions.close },
                },
            },
        }
    end,
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
        local utils = require "utils"
        local conditional_func = utils.conditional_func
        conditional_func(telescope.load_extension, pcall(require, "noice"), "noice")
        conditional_func(telescope.load_extension, pcall(require, "aerial"), "aerial")
        conditional_func(telescope.load_extension, utils.is_available "telescope-fzf-native.nvim", "fzf")
    end,
}
