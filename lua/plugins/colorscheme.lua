return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        aerial = true,
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
        },
        mason = true,
        noice = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
        nvimtree = true,
      }
    }
  }
}
