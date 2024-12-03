local M = {
	win = nil,
}

local ns_id = vim.api.nvim_create_namespace("buf_manager")

local event = require("nui.utils.autocmd").event
vim.api.nvim_create_autocmd({ event.BufNewFile, event.BufRead }, {
	desc = "Update buffer manager ui",
	callback = function(_)
		if M.win ~= nil and M.win.buf ~= nil and M.win:valid() then
			vim.schedule(function()
				M.render(M.win.buf)
				M.win:update()
			end)
		end
	end,
})

---@param bufnr number
function M.render(bufnr)
	local devicon = require("nvim-web-devicons")
	local NuiText = require("nui.text")

	local current_buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
	vim
		.iter(vim.api.nvim_list_bufs())
		:filter(function(buf)
			return vim.fn.buflisted(buf) ~= 0
		end)
		:enumerate()
		:each(function(i, buf)
			local bufname = vim.api.nvim_buf_get_name(buf)
			local norm_bufname = vim.fn.fnamemodify(bufname, ":.")
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
			local icon, icon_hl = devicon.get_icon_by_filetype(filetype, { default = true })

			if norm_bufname == "" then
				norm_bufname = "[No Text]"
			end

			vim.api.nvim_buf_set_lines(bufnr, i - 1, i - 1, false, { norm_bufname })
			if current_buf ~= buf then
				vim.api.nvim_buf_set_extmark(bufnr, ns_id, i - 1, 0, {
					end_col = norm_bufname:len(),
					end_line = i - 1,
					hl_group = "@comment",
				})
			end

			local virt_text = {
				{ icon .. "  ", icon_hl },
			}
			vim.api.nvim_buf_set_extmark(bufnr, ns_id, i - 1, 0, {
				virt_text = virt_text,
				virt_text_pos = "inline",
				right_gravity = false,
				invalidate = true,
			})

			-- local diag_cnt = {}
			-- for j = 1, 4, 1 do
			-- 	diag_cnt[#diag_cnt + 1] = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity[j] })
			-- end
		end)
end

function M:select(item)
	local buf_name = "^" .. item .. "$"
	local bufnr = vim.fn.bufnr(buf_name)

	if bufnr > -1 then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if win ~= self.win.win and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
				vim.schedule(function()
					vim.api.nvim_win_set_buf(win, bufnr)
					vim.api.nvim_set_current_win(win)
				end)
				return
			end
		end
	end
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
		keys = {
			["<cr>"] = function(_)
				local item = vim.api.nvim_get_current_line()
				self:select(item)
			end,
		},
	})
end

return M
