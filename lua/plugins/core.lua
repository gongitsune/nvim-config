return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("utils.icons").which_key
			---@module "which-key"
			---@type wk.Opts
			return {
				preset = "modern",
				icons = {
					rules = {
						{ pattern = "close", icon = icons.BufferClose, color = "red" },
						{ pattern = "find", icon = icons.Search, color = "yellow" },
						{ pattern = "packages", icon = icons.Package, color = "cyan" },
						{ pattern = "lsp", icon = icons.ActiveLSP, color = "green" },
						{ pattern = "ui/ux", icon = icons.Window, color = "cyan" },
						{ pattern = "buffer", icon = icons.Tab, color = "cyan" },
						{ pattern = "debugger", icon = icons.Debugger, color = "orange" },
						{ pattern = "git", icon = icons.Git, color = "blue" },
						{ pattern = "session", icon = icons.Session, color = "blue" },
						{ pattern = "terminal", icon = icons.Terminal, color = "green" },
					},
				},
				disable = {
					ft = {
						"TelescopePrompt",
					},
				},
			}
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				desc = "Move to left split",
				mode = { "n", "t" },
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				desc = "Move to below split",
				mode = { "n", "t" },
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				desc = "Move to above split",
				mode = { "n", "t" },
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				desc = "Move to right split",
				mode = { "n", "t" },
			},
			{
				"<C-Up>",
				function()
					require("smart-splits").resize_up()
				end,
				desc = "Resize split up",
				mode = { "n", "t" },
			},
			{
				"<C-Down>",
				function()
					require("smart-splits").resize_down()
				end,
				desc = "Resize split down",
				mode = { "n", "t" },
			},
			{
				"<C-Left>",
				function()
					require("smart-splits").resize_left()
				end,
				desc = "Resize split left",
				mode = { "n", "t" },
			},
			{
				"<C-Right>",
				function()
					require("smart-splits").resize_right()
				end,
				desc = "Resize split right",
				mode = { "n", "t" },
			},
		},
		opts = {
			ignored_filetypes = { "nofile", "quickfix", "qf", "prompt", "oil" },
			ignored_buftypes = { "nofile" },
		},
	},
	{
		"nmac427/guess-indent.nvim",
		cmd = "GuessIndent",
		event = { "BufRead", "BufNewFile" },
		opts = {
			filetype_exclude = {
				"oil",
				"harpoon",
			},
			auto_cmd = true,
		},
	},
}
