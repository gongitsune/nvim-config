local M = {}

local function get_config_path()
	return vim.uv.cwd() .. "/" .. "cspell.json"
end

local function create_config_file()
	local content = [[
  {
    "version": "0.2",
    "language": "en",
    "words": []
  }
  ]]

	local config_path = get_config_path()
	local stat = vim.uv.fs_stat(config_path)
	if not (stat and stat.type == "file") then
		local fd = vim.uv.fs_open(config_path, "w", 420)
		if not fd then
			vim.notify("Unable to create " .. config_path, vim.log.levels.ERROR, { title = "cspell util" })
			return
		end

		vim.uv.fs_write(fd, content)
		vim.uv.fs_close(fd)
	end
end

---@param word string
function M.add_word_to_workspace(word)
	create_config_file()

	local config_path = get_config_path()
	io.popen(
		string.format(
			[[bash -c "jq '.words += [\"%s\"]' %s > cspell_tmp.json && mv cspell_tmp.json %s"]],
			word,
			config_path,
			config_path
		)
	)

	vim.notify(
		string.format('"%s" is append to "%s"', word, config_path),
		vim.log.levels.INFO,
		{ title = "cspell util" }
	)

	if vim.api.nvim_get_option_value("modifiable", {}) then
		vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
		vim.api.nvim_command("silent! undo")
	end
end

return M
