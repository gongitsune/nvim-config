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
