local autocmd = vim.api.nvim_create_autocmd
local event = require("nui.utils.autocmd").event

autocmd(event.BufEnter, {
  once = true,
  callback = function()
    require("features.virtbuf"):open()
  end,
})
