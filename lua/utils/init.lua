local M = {}

---@param name string
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
	local plugin = M.get_plugin(name)
	path = path and "/" .. path or ""
	return plugin and (plugin.dir .. path)
end

---@param name string
function M.opts(name)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

function M.deprecate(old, new)
	M.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), {
		title = "LazyVim",
		once = true,
		stacktrace = true,
		stacklevel = 6,
	})
end

return M
