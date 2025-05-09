return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				javascript = { "biome" },
				python = { "ruff" }
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePre",
		config = function()
			require("lint").linters_by_ft = {
				lua = { "selene" },
				cpp = { "clangtidy" },
				typescript = { "biomejs" },
				typescriptreact = { "biomejs" },
				javascript = { "biomejs" },
				json = { "biomejs" },
				python = { "ruff" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
					require("lint").try_lint("cspell")
				end,
			})
		end,
	},
}
