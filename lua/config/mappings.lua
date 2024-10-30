local utils = require "utils"
local is_available = utils.is_available

local wk = require("which-key")

wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>p", group = "Packages" },
    { "<leader>l", group = "LSP" },
    { "<leader>u", group = "UI/UX" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debugger" },
    { "<leader>g", group = "Git" },
    { "<leader>S", group = "Session" },
    { "<leader>t", group = "Terminal" },
})

-- Normal --
-- Standard Operations
wk.add({
    mode = { "n" },
    -- { "j",         "v:count == 0 ? 'gj' : 'j'", expr = true,              desc = "Move cursor down" },
    -- { "k",         "v:count == 0 ? 'gk' : 'k'", expr = true,              desc = "Move cursor up" },
    { "<leader>w", "<cmd>w<cr>",            desc = "Save" },
    { "<leader>q", "<cmd>confirm q<cr>",    desc = "Quit" },
    { "<leader>Q", "<cmd>confirm qall<cr>", desc = "Quit all" },
    { "<leader>n", "<cmd>enew<cr>",         desc = "New File" },
    { "<C-s>",     "<cmd>w!<cr>",           desc = "Force write" },
    { "<C-q>",     "<cmd>qa!<cr>",          desc = "Force quit" },
    { "|",         "<cmd>vsplit<cr>",       desc = "Vertical Split" },
    { "\\",        "<cmd>split<cr>",        desc = "Horizontal Split" },
})

wk.add({
    mode = { "i" },
    { "jk",    "<esc>",   desc = "Exit insert mode" },
    { "<C-k>", "<up>",    desc = "Move cursor up" },
    { "<C-j>", "<down>",  desc = "Move cursor down" },
    { "<C-h>", "<left>",  desc = "Move cursor left" },
    { "<C-l>", "<right>", desc = "Move cursor right" },
})

-- Plugin Manager
wk.add({
    mode = { "n" },
    { "<leader>pi", "<cmd>lua require('lazy').install()<cr>", desc = "Plugins Install" },
    { "<leader>ps", "<cmd>lua require('lazy').home()<cr>",    desc = "Plugins Status" },
    { "<leader>pS", "<cmd>lua require('lazy').sync()<cr>",    desc = "Plugins Sync" },
    { "<leader>pu", "<cmd>lua require('lazy').check()<cr>",   desc = "Plugins Check Updates" },
    { "<leader>pU", "<cmd>lua require('lazy').update()<cr>",  desc = "Plugins Update" },
})

-- Manage Buffers
wk.add({
    mode = { "n" },
    { "<leader>bc", "<cmd>bufdo bw<cr>",          desc = "Close all buffers" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
})
wk.add({
    mode = { "n" },
    { "<leader>c", "<cmd>bw<cr>",    desc = "Close buffer" },
    { "<leader>C", "<cmd>bw!<cr>",   desc = "Close buffer (force)" },
    { "]b",        "<cmd>bnext<cr>", desc = "Next buffer" },
    { "[b",        "<cmd>bprev<cr>", desc = "Previous buffer" },
    { "]t",        "<cmd>tnext<cr>", desc = "Next tab" },
    { "[t",        "<cmd>tprev<cr>", desc = "Previous tab" },
})

-- Comment
if is_available("Comment.nvim") then
    wk.add({
        {
            mode = { "n" },
            {
                "<leader>/",
                function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
                desc = "Toggle comment line",
            },
        },
        {
            mode = { "v" },
            {
                "<leader>/",
                "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
                desc = "Toggle comment for selection",
            }
        }
    })
end

-- GitSigns
if is_available("gitsigns.nvim") then
    wk.add({
        mode = { "n" },
        { "<leader>gl", function() require("gitsigns").blame_line() end,               desc = "View Git blame" },
        { "<leader>gL", function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" },
        { "<leader>gp", function() require("gitsigns").preview_hunk() end,             desc = "Preview Git hunk" },
        { "<leader>gh", function() require("gitsigns").reset_hunk() end,               desc = "Reset Git hunk" },
        { "<leader>gr", function() require("gitsigns").reset_buffer() end,             desc = "Reset Git buffer" },
        { "<leader>gs", function() require("gitsigns").stage_hunk() end,               desc = "Stage Git hunk" },
        { "<leader>gS", function() require("gitsigns").stage_buffer() end,             desc = "Stage Git buffer" },
        { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end,          desc = "Unstage Git hunk" },
        { "<leader>gd", function() require("gitsigns").diffthis() end,                 desc = "View Git diff" },
        { "[g",         function() require("gitsigns").prev_hunk() end,                desc = "Previous Git hunk" },
        { "]g",         function() require("gitsigns").next_hunk() end,                desc = "Next Git hunk" },
    })
end

-- Oil.nvim
wk.add({
    mode = { "n" },
    { "<leader>e", function() require("oil").toggle_float(".") end, desc = "Open Oil" },
})

-- Resession
if is_available("resession.nvim") then
    wk.add({
        mode = { "n" },
        { "<leader>Sl", function() require("resession").load "Last Session" end, desc = "Load last session" },
        { "<leader>Ss", function() require("resession").save() end,              desc = "Save this session" },
        { "<leader>St", function() require("resession").save_tab() end,          desc = "Save this tab's session" },
        { "<leader>Sd", function() require("resession").delete() end,            desc = "Delete a session" },
        { "<leader>Sf", function() require("resession").load() end,              desc = "Load a session" },
        {
            "<leader>S.",
            function()
                require("resession").load(vim.fn.getcwd(), { dir = "dirsession" })
            end,
            desc = "Load current directory session"
        },
    })
end

-- Smart splits
wk.add({
    mode = { "n" },
    { "<C-h>",     function() require("smart-splits").move_cursor_left() end,  desc = "Move to left split" },
    { "<C-j>",     function() require("smart-splits").move_cursor_down() end,  desc = "Move to below split" },
    { "<C-k>",     function() require("smart-splits").move_cursor_up() end,    desc = "Move to above split" },
    { "<C-l>",     function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    { "<C-Up>",    function() require("smart-splits").resize_up() end,         desc = "Resize split up" },
    { "<C-Down>",  function() require("smart-splits").resize_down() end,       desc = "Resize split down" },
    { "<C-Left>",  function() require("smart-splits").resize_left() end,       desc = "Resize split left" },
    { "<C-Right>", function() require("smart-splits").resize_right() end,      desc = "Resize split right" },
})

-- Symbols outline
wk.add({
    mode = { "n" },
    { "<leader>lS", function() require("aerial").toggle() end, desc = "Symbols Outline" },
})

-- Telescope
wk.add({
    mode = { "n" },
    {
        "<leader>gb",
        function() require("telescope.builtin").git_branches { use_file_path = true } end,
        desc = "Git branches"
    },
    {
        "<leader>gc",
        function() require("telescope.builtin").git_commits { use_file_path = true } end,
        desc = "Git commits (repository)"
    },
    {
        "<leader>gC",
        function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
        desc = "Git commits (current file)"
    },
    {
        "<leader>gt",
        function() require("telescope.builtin").git_status { use_file_path = true } end,
        desc = "Git status"
    },
    { "<leader>f<CR>", function() require("telescope.builtin").resume() end,                    desc = "Resume previous search" },
    { "<leader>f'",    function() require("telescope.builtin").marks() end,                     desc = "Find marks" },
    { "<leader>f/",    function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find words in current buffer" },
    { "<leader>fb",    function() require("telescope.builtin").buffers() end,                   desc = "Find buffers" },
    { "<leader>fc",    function() require("telescope.builtin").grep_string() end,               desc = "Find word under cursor" },
    { "<leader>fC",    function() require("telescope.builtin").commands() end,                  desc = "Find commands" },
    { "<leader>ff",    function() require("telescope.builtin").find_files() end,                desc = "Find files" },
    {
        "<leader>fF",
        function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
        desc = "Find all files"
    },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end,   desc = "Find keymaps" },
    { "<leader>fm", function() require("telescope.builtin").man_pages() end, desc = "Find man" },
    {
        "<leader>fn",
        function() require("telescope").extensions.notify.notify() end,
        desc = "Find notifications"
    },
    {
        "<leader>uD",
        function() require("notify").dismiss { pending = true, silent = true } end,
        desc = "Dismiss notifications"
    },
    { "<leader>fo", function() require("telescope.builtin").oldfiles() end,  desc = "Find history" },
    { "<leader>fr", function() require("telescope.builtin").registers() end, desc = "Find registers" },
    {
        "<leader>ft",
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        desc = "Find themes"
    },
    { "<leader>fw", function() require("telescope.builtin").live_grep() end, desc = "Find words" },
    {
        "<leader>fW",
        function()
            require("telescope.builtin").live_grep {
                additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
        end,
        desc = "Find words in all files"
    },
    {
        "<leader>ls",
        function()
            local aerial_avail, _ = pcall(require, "aerial")
            if aerial_avail then
                require("telescope").extensions.aerial.aerial()
            else
                require("telescope.builtin").lsp_document_symbols()
            end
        end,
        desc = "Search symbols"
    },
})

-- Terminal
wk.add({
    {
        mode = { "n" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Toggle terminal float" },
        { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Toggle terminal horizontal split" },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Toggle terminal vertical split" },
        { "<C-t>",      '<cmd>execute v:count . "ToggleTerm"<cr>',          desc = "Toggle terminal" },
        { "<C-'>",      "<cmd>ToggleTerm<cr>",                              desc = "Toggle terminal" },
    },
    {
        mode = { "i" },
        { "<C-t>", "<esc><cmd>execute v:count . 'ToggleTerm'<cr>", desc = "Toggle terminal" },
        { "<C-'>", "<esc><cmd>ToggleTerm<cr>",                     desc = "Toggle terminal" },
    },
    {
        mode = { "t" },
        { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        { "<C-'>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
})

if vim.fn.executable "lazygit" == 1 then
    wk.add({
        mode = { "n" },
        {
            "<leader>gg",
            function()
                local worktree = require("utils.git").file_worktree()
                local flags = worktree
                    and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                    or ""
                utils.toggle_term_cmd("lazygit " .. flags)
            end,
            desc = "Toggle lazygit"
        },
    })
end

-- Stay in indent mode
wk.add({
    mode = { "v" },
    { "<S-Tab>", "<gv", desc = "Unindent line" },
    { "<Tab>",   ">gv", desc = "Indent line" },
})

-- Improved terminal navigation
wk.add({
    mode = { "t" },
    { "<C-h>", "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" },
    { "<C-j>", "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" },
    { "<C-k>", "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" },
    { "<C-l>", "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" },
    { "jk",    "<c-\\><c-n>",       desc = "Terminal up line navigation" },
})

wk.add({
    mode = { "n" },
    { "<leader>uC", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer" },
})
