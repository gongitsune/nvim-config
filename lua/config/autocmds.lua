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
        if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
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
