return {
	{
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	{
		"stevearc/oil.nvim",
		cmd = { "Oil" },
		keys = {
			{
				"<leader>e",
				function()
					require("oil").toggle_float()
					vim.defer_fn(function()
						require("oil").open_preview()
					end, 100)
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

			local lint_progress = function()
				local linters = require("lint").get_running()
				if #linters == 0 then
					return "󰦕"
				end
				return "󱉶 " .. table.concat(linters, ", ")
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
					lualine_x = { lint_progress, indent_style },
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
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = {
			indent = {
				enable = true,
				chars = {
					"│",
				},
				style = {
					vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				},
			},
			chunk = {
				enable = true,
				delay = 10,
				duration = 100,
				exclude_filetypes = {
					help = true,
					startify = true,
					aerial = true,
					alpha = true,
					dashboard = true,
					lazy = true,
					neogitstatus = true,
					NvimTree = true,
					neo = true,
					Trouble = true,
				},
			},
		},
	},
	{
		"gongitsune/actions-preview.nvim",
		opts = {
			telescope = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					width = 0.8,
					height = 0.9,
					prompt_position = "top",
					preview_cutoff = 20,
					preview_height = function(_, _, max_lines)
						return max_lines - 15
					end,
				},
			},
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = { "BufRead", "BufNewFile" },
		opts = {
			sign = {
				enabled = false,
			},
			virtual_text = {
				enabled = true,
			},
			autocmd = {
				enabled = true,
			},
		},
	},
}
