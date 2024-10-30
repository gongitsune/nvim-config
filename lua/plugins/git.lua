local icons = require "utils.nerd_icons"
return {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable "git" == 1,
    event = "User CustomGitFile",
    opts = {
        signs = {
            add = { text = icons.GitSign },
            change = { text = icons.GitSign },
            delete = { text = icons.GitSign },
            topdelete = { text = icons.GitSign },
            changedelete = { text = icons.GitSign },
            untracked = { text = icons.GitSign },
        },
        worktrees = vim.g.git_worktrees,
    },
}
