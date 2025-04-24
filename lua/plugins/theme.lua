return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			integrations = {
				blink_cmp = true,
				gitsigns = true,
				treesitter = true,
				mini = {
					enabled = true,
				},
				mason = true,
				which_key = true,
				snacks = {
					enabled = true,
					indent_scope_color = "",
				},
				lsp_trouble = true
			},
		},
	},
}
