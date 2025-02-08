return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>gg",
				function()
					require("snacks").lazygit.open()
				end,
				desc = "Open lazygit with snacks",
			},
			{
				"<leader>tf",
				function()
					require("snacks.terminal").toggle("fish", {
						win = {
							width = 0.8,
							height = 0.8,
							border = "rounded",
						},
					})
				end,
				desc = "Toggle terminal",
			},
			{
				"<leader>th",
				function()
					require("snacks.terminal").toggle(nil, {
						win = {
							height = 0.2,
						},
					})
				end,
				desc = "Toggle vertical terminal",
			},
			{
				"<leader>tH",
				function()
					require("snacks.terminal").open(nil, {
						win = {
							height = 0.2,
						},
					})
				end,
				desc = "Open vertical terminal",
			},
		},
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			lazygit = { enabled = true },
			scroll = {
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
				animate_repeat = {
					delay = 100,
					duration = { step = 5, total = 50 },
					easing = "linear",
				},
				filter = function(buf)
					return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
				end,
			}
		},
	},
}
