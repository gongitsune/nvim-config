return {
  {
    'mrcjkb/rustaceanvim',
    ft = "rust",
    lazy = false,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta" }
}
