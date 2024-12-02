return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		keys = {
			{
				"<leader>H",
				function()
					local buf = vim.api.nvim_get_current_buf()
					local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
					if filetype == nil or filetype == "" then
						return
					end

					require("harpoon"):list():add()
					vim.notify("The current buffer has been added to the harpoon list", vim.log.levels.INFO)
				end,
				desc = "Harpoon file",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					local height = math.floor(vim.api.nvim_win_get_height(0) * 0.8)
					height = math.min(height, math.max(5, #harpoon:list()))
					harpoon.ui:toggle_quick_menu(harpoon:list(), {
						border = "rounded",
						title_pos = "center",
						ui_width_ratio = 0.6,
						height_in_lines = height,
					})
				end,
				desc = "Harpoon quick menu",
			},
			{
				"[h",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Previous buffers stored within Harpoon list",
			},
			{
				"]h",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Next buffers stored within Harpoon list",
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
					local buf_names = {}
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if
							vim.api.nvim_buf_is_valid(buf)
							and vim.api.nvim_buf_is_loaded(buf)
							and vim.fn.buflisted(buf) == 1
						then
							local buf_name = vim.api.nvim_buf_get_name(buf)
							local normal_buf_name = vim.fn.fnamemodify(buf_name, ":.")

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
							diagnostics[normal_buf_name] = buf_diagnostics
							buf_names[normal_buf_name] = buf
						end
					end

					local current_file = vim.fn.fnamemodify(cx.current_file, ":.")
					for i, item in ipairs(list.items) do
						local ext = vim.fn.fnamemodify(item.value, ":e")
						if ext == nil then
							goto continue
						end

						local icon, icon_hl = devicon.get_icon(item.value, ext, { default = true })
						vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
							virt_text = { { icon .. "  ", icon_hl } },
							virt_text_pos = "inline",
							right_gravity = false,
							invalidate = true,
						})

						local virt_text = {}

						if buf_names[item.value] ~= nil then
							local is_modified =
								vim.api.nvim_get_option_value("modified", { buf = buf_names[item.value] })
							if is_modified then
								virt_text[#virt_text + 1] = {
									"[+]",
								}
							end
						end

						if diagnostics[item.value] ~= nil then
							local diag_cnts = diagnostics[item.value]
							local diag_icons = {
								{ hl = "DiagnosticError", icon = icons.diagnostics.Error },
								{ hl = "DiagnosticWarn", icon = icons.diagnostics.Warn },
								{ hl = "DiagnosticInfo", icon = icons.diagnostics.Info },
								{ hl = "DiagnosticHint", icon = icons.diagnostics.Hint },
							}

							for index, diag_cnt in ipairs(diag_cnts) do
								if diag_cnt ~= 0 then
									virt_text[#virt_text + 1] = {
										" " .. diag_icons[index].icon .. diag_cnt,
										diag_icons[index].hl,
									}
								end
							end
						end

						vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
							virt_text = virt_text,
						})

						if item.value == current_file then
							vim.schedule(function()
								vim.api.nvim_win_set_cursor(cx.win_id, { i, 0 })
							end)
						end

						::continue::
					end
				end,
			})
		end,
	},
}
