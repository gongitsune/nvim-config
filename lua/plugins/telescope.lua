return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		enabled = vim.fn.executable("make") == 1,
		build = "make",
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches({ use_file_path = true })
				end,
				desc = "Git branches",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits({ use_file_path = true })
				end,
				desc = "Git commits (repository)",
			},
			{
				"<leader>gC",
				function()
					require("telescope.builtin").git_bcommits({ use_file_path = true })
				end,
				desc = "Git commits (current file)",
			},
			{
				"<leader>gt",
				function()
					require("telescope.builtin").git_status({ use_file_path = true })
				end,
				desc = "Git status",
			},
			{
				"<leader>f<CR>",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "Resume previous search",
			},
			{
				"<leader>f'",
				function()
					require("telescope.builtin").marks()
				end,
				desc = "Find marks",
			},
			{
				"<leader>f/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Find words in current buffer",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "Find word under cursor",
			},
			{
				"<leader>fC",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Find commands",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fF",
				function()
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
				end,
				desc = "Find all files",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Find help",
			},
			{
				"<leader>fk",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "Find keymaps",
			},
			{
				"<leader>fm",
				function()
					require("telescope.builtin").man_pages()
				end,
				desc = "Find man",
			},
			{
				"<leader>fn",
				"<cmd>Telescope noice<cr>",
				desc = "Find notifications",
			},
			{
				"<leader>uD",
				function()
					require("notify").dismiss({ pending = true, silent = true })
				end,
				desc = "Dismiss notifications",
			},
			{
				"<leader>fo",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Find history",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").registers()
				end,
				desc = "Find registers",
			},
			{
				"<leader>ft",
				function()
					require("telescope.builtin").colorscheme({ enable_preview = true })
				end,
				desc = "Find themes",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Find words",
			},
			{
				"<leader>fW",
				function()
					require("telescope.builtin").live_grep({
						additional_args = function(args)
							return vim.list_extend(args, { "--hidden", "--no-ignore" })
						end,
					})
				end,
				desc = "Find words in all files",
			},
		},
		opts = function()
			local icons = require("utils.icons")
			local actions = require("telescope.actions")

			return {
				defaults = {
					prompt_prefix = icons.telescope.Selected .. " ",
					selection_caret = icons.telescope.Selected .. " ",
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						n = { q = actions.close },
					},
				},
				extensions = {
					noice = {},
					fzf = {},
				},
			}
		end,
	},
}
