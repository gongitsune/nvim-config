_G.Config = {}

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
-- Use Config.now when launched with args, otherwise Config.later
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
