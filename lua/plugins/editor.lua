return {
  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        ["<CR>"] = { "accept", "fallback" },

        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono"
      },

      completion = {
        accept = {
          auto_brackets = { enabled = true }
        },
        ghost_text = {
          enabled = true,
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded"
          }
        },
        menu = {
          border = "rounded"
        },
        list = {
          window = {
            border = "rounded"
          }
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'numToStr/Comment.nvim',
    opts = {
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>",      desc = "Decrement Selection", mode = "x" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePre",
    config = function()
      require("lint").linters_by_ft = {
        lua = { "selene" },
        cpp = { "clangtidy" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
        javascript = { "biomejs" },
        json = { "biomejs" },
        python = { "ruff" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
          require("lint").try_lint("cspell")
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang-format" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        javascript = { "biome" },
        python = { "ruff" }
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
