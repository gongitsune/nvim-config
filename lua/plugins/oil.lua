return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          -- if oil
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
  }
}
