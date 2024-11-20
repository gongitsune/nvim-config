local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end

	local oldcmdheight = vim.opt.cmdheight
	vim.opt.cmdheight = 1
	vim.notify("Please wailt while plugins are installed...")
	vim.api.nvim_create_autocmd("User", {
		desc = "Load Mason and Treesitter after Lazy installs plugins",
		once = true,
		pattern = "LazyInstall",
		callback = function()
			vim.cmd.bw()
			vim.opt.cmdheight = oldcmdheight
			vim.tbl_map(function(module)
				pcall(require, module)
			end, { "nvim-treesitter", "mason" })
		end,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = { lazy = true },
	performance = {
		rtp = {
			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
		},
	},
	ui = {
		border = "rounded",
	},
})
