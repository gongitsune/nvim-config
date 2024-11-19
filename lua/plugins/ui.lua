return {
	{
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	{
		"stevearc/oil.nvim",
		cmd = { "Oil" },
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "compact",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("utils.icons")
			local indent_style = function()
				if vim.bo.expandtab then
					return vim.bo.shiftwidth .. " space"
				else
					return vim.bo.tabstop .. " tab"
				end
			end
			return {
				options = {
					component_separators = "",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
					},
					lualine_x = { indent_style },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_b = {
						{
							"filetype",
							icon_only = true,
							padding = { left = 1, right = 0 },
						},
						"encoding",
						"fileformat",
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {
					"lazy",
					"oil",
					"quickfix",
					"man",
				},
			}
		end,
	},
}
