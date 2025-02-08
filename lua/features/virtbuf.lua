---@module "snacks"

---@class BufInfo
---@field bufnr number
---@field name string
---@field icon string
---@field icon_hl string
---@field filetype string
---@field modified boolean

---@class virtbuf
---@field win snacks.win | nil
---@field buffers table<number, BufInfo>
local M = {
	win = nil,
	augroup = nil,
	buffers = {},
}

function M:find_main_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= self.win.win and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
			return win
		end
	end
	return nil
end

function M:collect_buffers()
	local devicon = require("nvim-web-devicons")

	self.buffers = vim.iter(vim.api.nvim_list_bufs())
			:filter(function(bufnr)
				return vim.fn.buflisted(bufnr) == 1
			end)
			:map(function(bufnr)
				local bufname = vim.fn.bufname(bufnr)
				local filetype = vim.bo[bufnr].filetype
				local icon, icon_hl = devicon.get_icon_by_filetype(filetype, { default = true })
				local modified = vim.bo[bufnr].modified

				---@type BufInfo
				return {
					bufnr = bufnr,
					name = bufname,
					icon = icon,
					icon_hl = icon_hl,
					filetype = filetype,
					modified = modified,
				}
			end)
			:totable()
end

function M:render()
	assert(self.win, "win is not initialized")
	local win_buf = self.win.buf
	assert(win_buf, "snacks win's buf is nil")

	vim.api.nvim_set_option_value("modifiable", true, { buf = win_buf })

	local ns_id = vim.api.nvim_create_namespace("virtbuf")
	vim.api.nvim_buf_clear_namespace(win_buf, ns_id, 0, -1)
	vim.api.nvim_buf_set_lines(win_buf, 0, -1, false, {})

	local main_win = self:find_main_win()
	local current_bufnr = -1
	if main_win then
		current_bufnr = vim.api.nvim_win_get_buf(main_win)
	end

	for i, buf_info in ipairs(self.buffers) do
		local name = vim.fn.fnamemodify(buf_info.name, ":.")
		if name == "" then
			name = "[No Name]"
		end
		vim.api.nvim_buf_set_lines(win_buf, i - 1, i - 1, true, {
			name,
		})
		vim.api.nvim_buf_set_extmark(win_buf, ns_id, i - 1, 0, {
			virt_text = { { buf_info.icon .. "  ", buf_info.icon_hl } },
			virt_text_pos = "inline",
			right_gravity = false,
			invalidate = true,
		})

		if buf_info.modified then
			vim.api.nvim_buf_set_extmark(win_buf, ns_id, i - 1, 0, {
				virt_text = { { "", "Changed" } },
				invalidate = true,
			})
		end

		if buf_info.bufnr ~= current_bufnr then
			vim.api.nvim_buf_add_highlight(win_buf, ns_id, "@comment", i - 1, 0, -1)
		end
	end

	-- delete the rest of the lines
	vim.api.nvim_buf_set_lines(win_buf, #self.buffers, -1, true, {})

	vim.api.nvim_set_option_value("modifiable", false, { buf = win_buf })
end

function M:select_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local buf_info = self.buffers[cursor[1]]
	if not buf_info then
		return
	end

	local main_win = self:find_main_win()
	if main_win then
		vim.schedule(function()
			vim.api.nvim_win_set_buf(main_win, buf_info.bufnr)
			vim.api.nvim_set_current_win(main_win)
		end)
	end
end

function M:delete_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local buf_info = self.buffers[cursor[1]]
	if not buf_info then
		return
	end

	Snacks.bufdelete.delete({
		buf = buf_info.bufnr,
	})
end

function M:correct_and_render()
	vim.schedule(function()
		if self.win and self.win:valid() then
			self:collect_buffers()
			self:render()
		end
	end)
end

function M:open()
	if self.win then
		if not self.win:valid() then
			self:collect_buffers()
			self.win:show()
			self:render()
		end
		return
	end

	self.augroup = vim.api.nvim_create_augroup("virtbuf", { clear = true })
	self.win = Snacks.win({
		relative = "editor",
		position = "left",
		width = 0.2,
		on_buf = function(_)
			self:correct_and_render()
		end,
		fixbuf = true,
		---@diagnostic disable-next-line: missing-fields
		wo = {
			spell = false,
			winfixbuf = true,
		},
		keys = {
			["<cr>"] = function(_)
				self:select_current_line()
			end,
			["d"] = function(_)
				self:delete_current_line()
				self:correct_and_render()
			end,
		},
	})

	local event = require("nui.utils.autocmd").event
	vim.api.nvim_create_autocmd({ event.BufEnter, event.BufDelete, event.BufWipeout }, {
		group = self.augroup,
		callback = function()
			if not self.win or not self.win:valid() then
				return
			end
			M:correct_and_render()
		end,
	})
end

function M:close()
	if self.win then
		self.win:close()
		self.win = nil
		if self.augroup then
			vim.api.nvim_del_augroup_by_id(self.augroup)
			self.augroup = nil
		end
	end
end

function M:toggle()
	if self.win and self.win:valid() then
		self:close()
	else
		self:open()
	end
end

return M
