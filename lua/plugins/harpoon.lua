return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		keys = {
			{
				"<leader>H",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon file",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					local height = math.floor(vim.api.nvim_win_get_height(0) * 0.8)
					harpoon.ui:toggle_quick_menu(harpoon:list(), {
						border = "rounded",
						title_pos = "center",
						ui_width_ratio = 0.6,
						height_in_lines = height,
					})
				end,
				desc = "Harpoon quick menu",
			},
		},
		---@module "harpoon"
		---@type HarpoonPartialConfig
		opts = {},
		config = function(_, opts)
			local harpoon = require("harpoon")
			harpoon:setup(opts)

			harpoon:extend({
				UI_CREATE = function(cx)
					---@type number
					local bufnr = cx.bufnr

					local ns = vim.api.nvim_create_namespace("HarpoonUICustomDisplay")
					vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

					local list = harpoon:list()

					vim.api.nvim_set_option_value("relativenumber", true, {
						win = cx.win_id,
					})

					local devicon = require("nvim-web-devicons")
					local icons = require("utils.icons")

					local diagnostics = {}
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if
							vim.api.nvim_buf_is_valid(buf)
							and vim.api.nvim_buf_is_loaded(buf)
							and vim.fn.buflisted(buf) == 1
						then
							local buf_name = vim.api.nvim_buf_get_name(buf)

							local severities = {
								vim.diagnostic.severity.ERROR,
								vim.diagnostic.severity.WARN,
								vim.diagnostic.severity.INFO,
								vim.diagnostic.severity.HINT,
							}
							local buf_diagnostics = {}

							for _, severity in ipairs(severities) do
								buf_diagnostics[severity] = #vim.diagnostic.get(buf, { severity = severity })
							end
							diagnostics[vim.fn.fnamemodify(buf_name, ":.")] = buf_diagnostics
						end
					end

					for i, item in ipairs(list.items) do
						local ext = vim.fn.fnamemodify(item.value, ":e")
						if ext == nil then
							goto continue
						end

						local icon, icon_hl = devicon.get_icon(item.value, ext, { default = true })
						vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
							virt_text = { { icon .. " ", icon_hl } },
							virt_text_pos = "inline",
						})
						if diagnostics[item.value] ~= nil then
							local diag_cnts = diagnostics[item.value]
							local diag_icons = {
								{ hl = "DiagnosticError", icon = icons.diagnostics.Error },
								{ hl = "DiagnosticWarn", icon = icons.diagnostics.Warn },
								{ hl = "DiagnosticInfo", icon = icons.diagnostics.Info },
								{ hl = "DiagnosticHint", icon = icons.diagnostics.Hint },
							}
							local virt_text = {}
							for index, diag_cnt in ipairs(diag_cnts) do
								if diag_cnt ~= 0 then
									virt_text[#virt_text + 1] = {
										" " .. diag_icons[index].icon .. diag_cnt,
										diag_icons[index].hl,
									}
								end
							end
							vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
								virt_text = virt_text,
							})
						end

						::continue::
					end
				end,
			})
		end,
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				callback = function(ev)
					local buf = ev.buf
					local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
					if not vim.list_contains({ "oil" }, filetype) then
						require("harpoon"):list():add()
					end
				end,
			})
		end,
	},
}
