local wk = require("which-key")

-- Normal --
-- Standard Operations
wk.add({
  mode = { "n" },
  { "<leader>w", "<cmd>w<cr>",            desc = "Save" },
  { "<leader>q", "<cmd>confirm q<cr>",    desc = "Quit" },
  { "<leader>Q", "<cmd>confirm qall<cr>", desc = "Quit all" },
  { "<leader>n", "<cmd>enew<cr>",         desc = "New File" },
  { "<C-s>",     "<cmd>w!<cr>",           desc = "Force write" },
  { "<C-q>",     "<cmd>qa!<cr>",          desc = "Force quit" },
  { "|",         "<cmd>vsplit<cr>",       desc = "Vertical Split" },
  { "\\",        "<cmd>split<cr>",        desc = "Horizontal Split" },
  { "]b",        "<cmd>bnext<cr>",        desc = "Next buffers" },
  { "[b",        "<cmd>bprev<cr>",        desc = "Previous buffers" },
  {
    "<leader>bc",
    function()
      Snacks.bufdelete.delete({
        buf = vim.api.nvim_get_current_buf(),
      })
    end,
    desc = "Delete current buffer",
  },
})

wk.add({
  mode = { "i" },
  { "jk",    "<esc>",   desc = "Exit insert mode" },
  { "<C-k>", "<up>",    desc = "Move cursor up" },
  { "<C-j>", "<down>",  desc = "Move cursor down" },
  { "<C-h>", "<left>",  desc = "Move cursor left" },
  { "<C-l>", "<right>", desc = "Move cursor right" },
})

wk.add({
  mode = { "t" },
  { "jk", "<C-\\><C-n>", desc = "Exit terminal mode" },
})
