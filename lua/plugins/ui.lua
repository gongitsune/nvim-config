return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          if vim.bo.filetype == "oil" then
            return
          end

          require("oil").open_float(
            nil,
            ---@type oil.OpenOpts
            { preview = { vertical = true } }
          )
        end,
        desc = "Toggle oil float",
      },
    },
    opts = function()
      ---@module 'oil'
      ---@type oil.SetupOpts
      return {
        keymaps = {
          ["q"] = "actions.close",
        },
        float = {
          max_width = math.floor(vim.o.columns * 0.8),
          max_height = math.floor(vim.o.lines * 0.8),
        },
        default_file_explorer = true,
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup(
      ---@module "bufferline",
      ---@type bufferline.UserConfig
        {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
          options = {
            close_command = function(n) Snacks.bufdelete(n) end,
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            show_buffer_close_icons = false,
            diagnostics_indicator = function(_, _, diag)
              local icons = {
                Error = " ",
                Warn  = " ",
                Hint  = " ",
                Info  = " ",
              }
              local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                  .. (diag.warning and icons.Warn .. diag.warning or "")
              return vim.trim(ret)
            end,
          }
        })
    end,
  }
}
