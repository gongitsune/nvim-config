local autocmd = vim.api.nvim_create_autocmd
local event = require("nui.utils.autocmd").event

autocmd(event.BufEnter, {
  once = true,
  callback = function()
    local virtbuf = require("features.virtbuf")
    virtbuf:open()

    -- Switch to the main window
    vim.defer_fn(function()
      local main_win = virtbuf:find_main_win()
      if main_win then
        vim.api.nvim_set_current_win(main_win)
      end
    end, 500)
  end,
})
