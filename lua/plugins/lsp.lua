return {
  {
    "stevearc/aerial.nvim",
    event = "User CustomFile",
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      disable_max_lines = vim.g.max_file.lines,
      disable_max_size = vim.g.max_file.size,
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["[y"] = "actions.prev",
        ["]y"] = "actions.next",
        ["[Y"] = "actions.prev_up",
        ["]Y"] = "actions.next_up",
        ["{"] = false,
        ["}"] = false,
        ["[["] = false,
        ["]]"] = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        opts = {
          ensure_installed = {
            "lua_ls"
          }
        },
        config = function(_, opts)
          local mason_lspconfig = require("mason-lspconfig")
          mason_lspconfig.setup(opts)
          mason_lspconfig.setup_handlers {
            -- Default handler
            function(server_name)
              require("lspconfig")[server_name].setup {}
            end,
            -- Custom handlers
            -- ["rust_analyzer"] = function()
            --     require("rust-tools").setup {}
            -- end
          }
        end
      },
    },
    event = "User CustomFile",
  },
}
