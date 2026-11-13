local misc = require("mini.misc")

local now, later, now_if_args = Config.now, Config.later, Config.now_if_args

now(function()
  vim.cmd('colorscheme minischeme')

  require('mini.icons').setup({})
  later(MiniIcons.tweak_lsp_kind)

  require('mini.notify').setup()
  require('mini.sessions').setup()
  require('mini.starter').setup()
  require('mini.statuscolumn').setup()
  require('mini.statusline').setup()
end)

now_if_args(function() 
  require('mini.files').setup({ windows = { preview = true }})

  require('mini.misc').setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
end)

later(function() 
  require('mini.extra').setup()
  require('mini.bufremove').setup()

  local miniclue = require('mini.clue')
  miniclue.setup({
    clues = {
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode = { 'n', 'x' }, keys = '[' },
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode =   'n',        keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
  })

  require('mini.extra').setup()
  require('mini.pick').setup()
  require('mini.align').setup()
  require('mini.bracketed').setup()
  require('mini.cmdline').setup()
  require('mini.comment').setup()
  require('mini.git').setup()
end)
