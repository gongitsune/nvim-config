local namespace = vim.api.nvim_create_namespace
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains(
      { "<CR>", "n", "N", "*", "#", "?", "/" },
      vim.fn.keytrans(char)
    )
    if vim.opt.hlsearch ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, namespace("auto_hlsearch"))

autocmd("BufReadPre", {
  desc = "Disable certain functionality on very large files",
  group = augroup("large_buf", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
        or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
  end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if buffers changed on editor focus",
  group = augroup("checktime", { clear = true }),
  command = "checktime",
})

autocmd("TermOpen", {
  group = augroup("terminal_settings", { clear = true }),
  desc = "Disable foldcolumn and signcolumn for terminals",
  callback = function()
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.signcolumn = "no"
  end,
})

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("q_close_windows", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    local target_buftypes = { "help", "nofile", "quickfix" }
    if
        vim.tbl_contains(target_buftypes, buftype)
        and vim.fn.maparg("q", "n") == ""
    then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
  desc = "Unlist quickfist buffers",
  group = augroup("unlist_quickfist", { clear = true }),
  pattern = "qf",
  callback = function() vim.opt_local.buflisted = false end,
})

autocmd("FileType", {
  desc = "configure editorconfig after filetype detection to override `ftplugin`s",
  group = augroup("editorconfig_filetype", { clear = true }),
  callback = function(args)
    if vim.F.if_nil(vim.b.editorconfig, vim.g.editorconfig, true) then
      local editorconfig_avail, editorconfig = pcall(require, "editorconfig")
      if editorconfig_avail then editorconfig.config(args.buf) end
    end
  end,
})

autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "AstroNvim user events for file detection (AstroFile and AstroGitFile)",
  group = augroup("file_user_events", { clear = true }),
  callback = function(args)
    local utils = require("utils")
    local emit_event = utils.event

    local current_file = vim.api.nvim_buf_get_name(args.buf)
    if not (current_file == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
      emit_event "File"
      if
          require("utils.git").file_worktree()
          or utils.cmd({ "git", "-C", vim.fn.fnamemodify(current_file, ":p:h"), "rev-parse" }, false)
      then
        emit_event "GitFile"
        vim.api.nvim_del_augroup_by_name "file_user_events"
      end
      vim.schedule(function() vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false }) end)
    end
  end,
})

-- Resession auto commands
autocmd("VimEnter", {
  callback = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      require("lspconfig")
      -- Save these to a different directory, so our manual sessions don't get polluted
      require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
    end
  end,
  nested = true,
})

autocmd("VimLeavePre", {
  callback = function()
    require("resession").save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
  end,
})
