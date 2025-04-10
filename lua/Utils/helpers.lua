local M = {}

M.table_include = function(tbl, item)
	for _, table_item in ipairs(tbl) do
		if item == table_item then
			return true
		end
	end

	return false
end

M.require_all = function(path, callback)
	local modules = {}

	for _, file in ipairs(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/" .. path, "*.lua", false, true)) do
		local file = file:match("lua/(.-)%.lua$")
		local key = file:match("[^/]+$")
		local content = require(file:gsub("/", "."))

		if not callback then
			modules[key] = content
		else
			return callback(content, key, file)
		end
	end

	if not callback then
		return modules
	end
end

return M
