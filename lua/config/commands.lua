vim.api.nvim_create_user_command("CSpellAppend", function(opts)
	local word = opts.args
	if not word or word == "" then
		word = vim.call("expand", "<cword>"):lower()
	end

	require("utils.cspell").add_word_to_workspace(word)
end, { nargs = "?" })
