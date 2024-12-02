local M = {
	win = nil,
}

local ns_id = vim.api.nvim_create_namespace("buf_manager")

---@param bufnr number
function M.render(bufnr)
	local devicon = require("nvim-web-devicons")
	local NuiText = require("nui.text")
	local NuiTable = require("nui.table")

	local data = vim.iter(vim.api.nvim_list_bufs())
		:filter(function(buf)
			return vim.fn.buflisted(buf) ~= 0
		end)
		:map(function(buf)
			local bufname = vim.api.nvim_buf_get_name(buf)
			local norm_bufname = vim.fn.fnamemodify(bufname, ":.")
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
			local icon, icon_hl = devicon.get_icon_by_filetype(filetype, { default = true })

			return {
				icon = NuiText(icon, { hl_group = icon_hl }),
				norm_bufname = norm_bufname,
				diagnostics = { 0, 0, 0, 0 },
			}
		end)
		:totable()

	local tbl = NuiTable({
		ns_id = ns_id,
		bufnr = bufnr,
		columns = {
			{
				accessor_key = "icon",
			},
			{
				accessor_key = "norm_bufname",
			},
		},
		data = data,
	})
	tbl:render()
end

function M:open()
	self.win = require("snacks.win")({
		width = 0.2,
		position = "left",
		on_buf = function(win)
			local bufnr = win.buf
			if bufnr ~= nil then
				self.render(bufnr)
			end
		end,
	})
end

return M
