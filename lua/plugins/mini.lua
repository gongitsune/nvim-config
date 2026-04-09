return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    "nvim-mini/mini.surround",
    event = "InsertEnter",
    opts = {
      mappings = {
        add = 'sa',        -- Add surrounding in Normal and Visual modes
        delete = 'sd',     -- Delete surrounding
        find = 'sf',       -- Find surrounding (to the right)
        find_left = 'sF',  -- Find surrounding (to the left)
        highlight = 'sh',  -- Highlight surrounding
        replace = 'sr',    -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
  },
  {
    "nvim-mini/mini.move",
    keys = {
      { "<M-h>", mode = { "n", "v" } },
      { "<M-j>", mode = { "n", "v" } },
      { "<M-l>", mode = { "n", "v" } },
      { "<M-k>", mode = { "n", "v" } },
    },
    opts = {}
  }
}
