local M = {}

---@param path string
M.require_all = function(path)
    local modules = {}
    local file_paths = vim.fn.globpath(
        vim.fn.stdpath("config") .. "/lua/" .. path,
        "*.lua",
        false,
        true
    )

    for _, file_path in ipairs(file_paths) do
        if vim.uv.fs_stat(file_path) then
            local basename = vim.fs.basename(file_path)
            local filename = basename:match("(.-)%.lua$")
            local modulepath = path:gsub("/", ".") .. "." .. filename
            local module = require(modulepath)

            modules[filename] = module
        end
    end

    return modules
end

return M
