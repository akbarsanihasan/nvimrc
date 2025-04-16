local M = {}

M.return_call = function(mix, ty)
	if type(mix) == ty then
		return mix
	end

	if type(mix) == "function" then
		return mix()
	end

	vim.notify(string.format("Invalid provider type for server '%s': %s", mix, type(mix)), vim.log.levels.ERROR)

	return nil
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
