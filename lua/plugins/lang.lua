return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact" },
    opts = {},
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    opts = {
      -- leave empty or see below
    },
  }
}
