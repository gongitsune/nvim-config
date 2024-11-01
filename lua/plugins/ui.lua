return {
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["r"] = "actions.refresh",
        ["t"] = "actions.open_terminal"
      },
      view_options = {
        is_hidden_file = function(name, _)
          return vim.startswith(name, ".")
        end
      }
    }
  },
  {
    "rcarriga/nvim-notify",
    init = function()
      require("utils").load_plugin_with_func("nvim-notify", vim, "notify")
    end,
    opts = {
      background_colour = "#000000",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "User CustomFile",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = { user_default_options = { names = false } }
  },
  {
    'stevearc/dressing.nvim',
    init = function()
      require("utils").load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" })
    end,
    opts = {
      input = { default_prompt = "➤ " },
      select = { backend = { "telescope", "builtin" } },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = "User CustomFile",
    opts = {
      indent = {
        enable = true,
        chars = {
          "│",
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
      },
      chunk = {
        enable = true,
        delay = 10,
        duration = 100,
        exclude_filetypes = {
          help = true,
          startify = true,
          aerial = true,
          alpha = true,
          dashboard = true,
          lazy = true,
          neogitstatus = true,
          NvimTree = true,
          neo = true,
          Trouble = true,
        }
      }
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      messages = {
        view = "mini"
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    'kosayoda/nvim-lightbulb',
    event = "User CustomFile",
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      float = { enabled = true },
    }
  },
  {
    "gongitsune/actions-preview.nvim",
    opts = {
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    }
  }
}
