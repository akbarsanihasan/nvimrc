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
		local file_path = file:match("lua/(.-)%.lua$")
		local key = file_path:match("[^/]+$")
		local module = require(file_path:gsub("/", "."))

		if not callback then
			modules[key] = module
		else
			return callback(module, key, file_path)
		end
	end

	if not callback then
		return modules
	end
end

return M
