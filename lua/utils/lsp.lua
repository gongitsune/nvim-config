local M = {}

---@class MapLspMethodOpts
---@field client vim.lsp.Client
---@field bufnr integer
---@field mappings table

---@param method string
---@param key_map table
---@param opts MapLspMethodOpts
local function map_lsp_method(method, key_map, opts)
	local client = opts.client
	if client.supports_method(method, { bufnr = opts.bufnr }) then
		table.insert(opts.mappings, key_map)
	end
end

---@param client vim.lsp.Client
---@param bufnr integer
local function lsp_key_map(client, bufnr)
	---@type MapLspMethodOpts
	local opts = {
		client = client,
		bufnr = bufnr,
		mappings = {},
	}

	map_lsp_method("textDocument/codeAction", {
		"<leader>la",
		function()
			require("actions-preview").code_actions()
		end,
		desc = "LSP code action",
	}, opts)
	map_lsp_method("textDocument/rename", {
		"<leader>lr",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "Rename current symbol",
	}, opts)
	map_lsp_method("textDocument/signatureHelp", {
		"<leader>lh",
		function()
			vim.lsp.buf.signature_help()
		end,
		desc = "Signature help",
	}, opts)
	map_lsp_method("textDocument/definition", {
		"gd",
		function()
			require("telescope.builtin").lsp_definitions()
		end,
		desc = "Show the definition of current symbol",
	}, opts)
	map_lsp_method("textDocument/implementation", {
		"gI",
		function()
			require("telescope.builtin").lsp_implementations()
		end,
		desc = "Implementation of current symbol",
	}, opts)
	map_lsp_method("textDocument/references", {
		"gr",
		function()
			require("telescope.builtin").lsp_references()
		end,
		desc = "References of current symbol",
	}, opts)
	map_lsp_method("textDocument/typeDefinition", {
		"gy",
		function()
			require("telescope.builtin").lsp_type_definitions()
		end,
		desc = "Definition of current type",
	}, opts)

	require("which-key").add({
		mode = { "n" },
		buffer = bufnr,
		opts.mappings,
		{
			"<leader>li",
			"<cmd>LspInfo<cr>",
			desc = "Open lsp info",
		},
	})
end

function M.register_lsp_keymap_event()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client ~= nil then
				lsp_key_map(client, ev.buf)
			end
		end,
	})
end

return M
