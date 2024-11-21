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
