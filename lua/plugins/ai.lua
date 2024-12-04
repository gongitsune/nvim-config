return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		opts = {
			filetypes = {
				gitcommit = true,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
}
