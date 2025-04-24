for _, source in ipairs({
	"config/options",
	"config/lazy",
	-- "config/commands",
	-- "config/autocmds",
	-- "config/mappings",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln(string.format("Failed to load %s\n\n%s", source, fault))
	end
end

-- apply colorscheme
vim.cmd.colorscheme("catppuccin")