return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "mason-org/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local nulls = require("null-ls")
        local mason_nulls = require("mason-null-ls")

        package.path = package.path
            .. ";" .. vim.fn.stdpath("config") .. "/nulls/?.lua"
            .. ";" .. vim.fn.stdpath("config") .. "/nulls/?/init.lua"
            .. ";" .. vim.fn.stdpath("config") .. "/nulls/?/?.lua"

        ---@param path string | nil
        local function load_custom_nulls(path)
            local modules = {}
            local file_paths = vim.fn.globpath(vim.fn.stdpath("config") .. "/nulls/" .. (path or ""), "*.lua",
                false, true)

            for _, file_path in ipairs(file_paths) do
                local basename = vim.fs.basename(file_path)
                local filename = basename:match("(.-)%.lua$")
                local module_path = file_path:match(path .. ".*"):match("(.-)%.lua$"):gsub("/", ".")
                local module = require(module_path)
                modules[filename] = module
            end

            return modules
        end

        nulls.setup()
        mason_nulls.setup({
            handlers = {
                function(server_name, methods)
                    if methods == nil or vim.tbl_isempty(methods) then
                        return
                    end

                    for _, method in ipairs(methods) do
                        local configs = load_custom_nulls(method)
                        local null_servers = vim.tbl_keys(configs)
                        local source = nulls.builtins[method][server_name]

                        if vim.tbl_contains(null_servers, server_name) then
                            source = nulls.builtins[method][server_name].with(configs[server_name])
                        end

                        nulls.register(source)
                    end
                end,
            },
        })
    end
}
