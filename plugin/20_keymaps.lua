Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },}

-- Helpers
local function nmap_leader(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local function xmap_leader(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

-- b is Buffer
nmap_leader('ba', '<Cmd>b#<CR>', 'Alternate')
nmap_leader('bd', function() MiniBufremove.delete() end, 'Delete')
nmap_leader('bD', function() MiniBufremove.delete(0, true) end, 'Delete!')

-- e is Explore
nmap_leader('E', function() MiniFiles.open() end, 'Directory')
nmap_leader('e', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, 'Files')

-- f is Fuzzy Find.
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',           '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',           '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',    'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf,                        'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                     'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                 'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',        'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',      'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',  'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>',                       'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                   'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',      'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                        'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                   'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',       'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',   'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                   'Modified hunks (all)')
nmap_leader('fn', '<Cmd>lua MiniNotify.show_history()<CR>',    'Notifications')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',          'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                      'Resume')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',      'References (LSP)')
nmap_leader('fs', pick_workspace_symbols_live,                 'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols document')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>',          'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths<CR>',                 'Visit paths (cwd)')

-- g is for 'Git'. Common usage:
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at cursor')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

-- l is for 'Language'. Common usage:
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',     'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>',   'Diagnostic popup')
nmap_leader('lf', '<Cmd>lua require("conform").format()<CR>',   'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',  'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>',           'Hover')
nmap_leader('ll', '<Cmd>lua vim.lsp.codelens.run()<CR>',        'Lens')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',          'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',      'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',      'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

xmap_leader('lf', '<Cmd>lua require("conform").format()<CR>', 'Format selection')

-- o is for 'Other'. Common usage:
nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>',    'Trim trailspace')
nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- s is for 'Session'. Common usage:
local session_new = 'vim.ui.input({ prompt = "Session name: " }, MiniSessions.write)'

nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>',         'New')
nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
nmap_leader('sR', '<Cmd>lua MiniSessions.restart()<CR>',        'Restart')
nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- t is for 'Terminal'
nmap_leader('tt', '<Cmd>horizontal term<CR>a', 'Terminal (horizontal)')
nmap_leader('tT', '<Cmd>vertical term<CR>a',   'Terminal (vertical)')

-- v is for 'Visits'. Common usage:
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

nmap_leader('vc', make_pick_core('',  'Core visits (all)'),       'Core visits (all)')
nmap_leader('vC', make_pick_core(nil, 'Core visits (cwd)'),       'Core visits (cwd)')
nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')
-- stylua: ignore end
