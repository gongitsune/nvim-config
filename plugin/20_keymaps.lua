Config.leader_group_clues = {
    { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
    { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
    { mode = "n", keys = "<Leader>f", desc = "+Find" },
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
    { mode = "n", keys = "<Leader>l", desc = "+Language" },
    { mode = "n", keys = "<Leader>o", desc = "+Other" },
    { mode = "n", keys = "<Leader>s", desc = "+Session" },

    { mode = "x", keys = "<Leader>g", desc = "+Git" },
    { mode = "x", keys = "<Leader>l", desc = "+Language" },
}

-- Helpers
local function nmap_leader(suffix, rhs, desc)
    vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local function xmap_leader(suffix, rhs, desc)
    vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

-- general keymaps
nmap_leader("w", "<Cmd>w<CR>", "Write")
nmap_leader("q", "<Cmd>q<CR>", "Quit")
nmap_leader("r", "<Cmd>restart<CR>", "Restart")

vim.keymap.set("n", "<Esc>", "<Cmd>noh<Cr>", { desc = "Clear hilight" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move sursor left" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move sursor Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move sursor Right" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move sursor Up" })

vim.keymap.set("t", "JK", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- b is Buffer
nmap_leader("ba", "<Cmd>b#<CR>", "Alternate")
nmap_leader("bd", function()
    MiniBufremove.delete()
end, "Delete")
nmap_leader("bD", function()
    MiniBufremove.delete(0, true)
end, "Delete!")

-- e is Explore
nmap_leader("E", function()
    MiniFiles.open()
end, "Directory")
nmap_leader("e", function()
    local path = vim.api.nvim_buf_get_name(0)

    if vim.bo.buftype == "" and path ~= "" then
        MiniFiles.open(path)
    else
        MiniFiles.open()
    end
end, "Files")

-- f is Fuzzy Find.
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap_leader("f/", '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader("f:", '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader("fa", '<Cmd>Pick git_hunks scope="staged"<CR>', "Added hunks (all)")
nmap_leader("fA", pick_added_hunks_buf, "Added hunks (buf)")
nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("fc", "<Cmd>Pick git_commits<CR>", "Commits (all)")
nmap_leader("fC", '<Cmd>Pick git_commits path="%"<CR>', "Commits (buf)")
nmap_leader("fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
nmap_leader("fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("<Leader>", "<Cmd>Pick files<CR>", "Files")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word")
nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
nmap_leader("fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
nmap_leader("fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
nmap_leader("fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (buf)")
nmap_leader("fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)")
nmap_leader("fn", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")
nmap_leader("fM", '<Cmd>Pick git_hunks path="%"<CR>', "Modified hunks (buf)")
nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fR", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
nmap_leader("fs", pick_workspace_symbols_live, "Symbols workspace (live)")
nmap_leader("fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols document")

-- g is for 'Git'. Common usage:
nmap_leader("gg", "<Cmd>terminal lazygit<CR>a", "Added diff")

vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit*",
    callback = function(ev)
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) then
                MiniBufremove.delete(ev.buf)
            end
        end)
    end,
})

-- l is for 'Language'. Common usage:
nmap_leader("la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic popup")
nmap_leader("lf", '<Cmd>lua require("conform").format()<CR>', "Format")
nmap_leader("li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
nmap_leader("lh", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
nmap_leader("ll", "<Cmd>lua vim.lsp.codelens.run()<CR>", "Lens")
nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
nmap_leader("lR", "<Cmd>lua vim.lsp.buf.references()<CR>", "References")
nmap_leader("ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition")
nmap_leader("lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")

xmap_leader("lf", '<Cmd>lua require("conform").format()<CR>', "Format selection")

-- o is for 'Other'. Common usage:
nmap_leader("or", "<Cmd>lua MiniMisc.resize_window()<CR>", "Resize to default width")
nmap_leader("ot", "<Cmd>lua MiniTrailspace.trim()<CR>", "Trim trailspace")
nmap_leader("oz", "<Cmd>lua MiniMisc.zoom()<CR>", "Zoom toggle")

-- s is for 'Session'. Common usage:
local session_new = 'vim.ui.input({ prompt = "Session name: " }, MiniSessions.write)'

nmap_leader("sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete")
nmap_leader("sn", "<Cmd>lua " .. session_new .. "<CR>", "New")
nmap_leader("sr", '<Cmd>lua MiniSessions.select("read")<CR>', "Read")
nmap_leader("sR", "<Cmd>lua MiniSessions.restart()<CR>", "Restart")
nmap_leader("sw", "<Cmd>lua MiniSessions.write()<CR>", "Write current")
