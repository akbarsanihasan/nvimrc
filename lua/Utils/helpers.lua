local M = {}

---@param path string
M.require_all = function(path)
	local modules = {}
	local path_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/" .. path, "*.lua", false, true)

	for _, file in ipairs(path_files) do
		local file_path = file:match("lua/(.-)%.lua$")
		local basename = file_path:match("[^/]+$")
		local module = require(file_path:gsub("/", "."))

		modules[basename] = module
	end

	return modules
end

return M
