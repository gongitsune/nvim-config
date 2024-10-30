local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
    opts = opts or {}
    return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Serve a notification with a title of User
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
    vim.schedule(function() vim.notify(msg, type, M.extend_tbl({ title = "User" }, opts)) end)
end

--- A helper function to wrap a module function to require a plugin before running
---@param plugin string The plugin to call `require("lazy").load` with
---@param module table The system module where the functions live (e.g. `vim.ui`)
---@param func_names string|string[] The functions to wrap in the given module (e.g. `{ "ui", "select }`)
function M.load_plugin_with_func(plugin, module, func_names)
    if type(func_names) == "string" then func_names = { func_names } end
    for _, func in ipairs(func_names) do
        local old_func = module[func]
        module[func] = function(...)
            module[func] = old_func
            require("lazy").load { plugins = { plugin } }
            module[func](...)
        end
    end
end

--- Call function if a condition is met
---@param func function The function to run
---@param condition boolean # Whether to run the function or not
---@RETURN ANY|NIL RESULT # THE RESULT OF THE FUNCTION RUNNING OR NIL
function M.conditional_func(func, condition, ...)
    -- if the condition is true, evaluate the function with the rest of the parameters and return the result
    if condition and type(func) == "function" then return func(...) end
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Trigger an Custom user event
---@param event string The event name to be appended to Custom
---@param delay? boolean Whether or not to delay the event asynchronously (Default: true)
function M.event(event, delay)
    local emit_event = function() vim.api.nvim_exec_autocmds("User", { pattern = "Custom" .. event, modeline = false }) end
    if delay == false then
        emit_event()
    else
        vim.schedule(emit_event)
    end
end

--- Run a shell command and capture the output and if the command succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
    if type(cmd) == "string" then cmd = { cmd } end
    if vim.fn.has "win32" == 1 then cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd) end
    local result = vim.fn.system(cmd)
    local success = vim.api.nvim_get_vvar "shell_error" == 0
    if not success and (show_error == nil or show_error) then
        vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
    end
    return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

--- Toggle a user terminal if it exists, if not then create a new one and save it
---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
function M.toggle_term_cmd(opts)
    local terms = {}

    -- if a command string is provided, create a basic table for Terminal:new() options
    if type(opts) == "string" then opts = { cmd = opts } end
    opts = M.extend_tbl({ hidden = true }, opts)
    local num = vim.v.count > 0 and vim.v.count or 1
    -- if terminal doesn't exist yet, create it
    if not terms[opts.cmd] then terms[opts.cmd] = {} end
    if not terms[opts.cmd][num] then
        if not opts.count then opts.count = vim.tbl_count(terms) * 100 + num end
        if not opts.on_exit then opts.on_exit = function() terms[opts.cmd][num] = nil end end
        terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
    end
    -- toggle the terminal
    terms[opts.cmd][num]:toggle()
end

return M
