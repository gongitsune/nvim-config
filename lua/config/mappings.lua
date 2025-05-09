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

-- Plugin Manager
wk.add({
	mode = { "n" },
	{ "<leader>pi", "<cmd>lua require('lazy').install()<cr>", desc = "Plugins Install" },
	{ "<leader>ps", "<cmd>lua require('lazy').home()<cr>",    desc = "Plugins Status" },
	{ "<leader>pS", "<cmd>lua require('lazy').sync()<cr>",    desc = "Plugins Sync" },
	{ "<leader>pu", "<cmd>lua require('lazy').check()<cr>",   desc = "Plugins Check Updates" },
	{ "<leader>pU", "<cmd>lua require('lazy').update()<cr>",  desc = "Plugins Update" },
})

-- BufManager
wk.add({
	mode = { "n" },
	{ "<leader>bb", "<cmd>BufManage<cr>", desc = "Buffer Manager" },
})

-- Comment
wk.add({
	mode = { "n" },
	{
		"<leader>/",
		require("Comment.api").call(
			"toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
			"g@$"
		),
		desc = "Comment Line",
		expr = true,
		silent = true,
	}
})
