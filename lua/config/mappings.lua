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
  { "<C-h>",     "<C-w>h",                desc = "Move to left split" },
  { "<C-j>",     "<C-w>j",                desc = "Move to bottom split" },
  { "<C-k>",     "<C-w>k",                desc = "Move to top split" },
  { "<C-l>",     "<C-w>l",                desc = "Move to right split" },
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
  { "JK", "<C-\\><C-n>", desc = "Exit terminal mode" },
})
