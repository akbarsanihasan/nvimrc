return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local helpers = require("Utils.helpers")
        local none_ls = require("null-ls")
        local mason_null_ls = require("mason-null-ls")

        none_ls.setup({
            update_in_insert = true,
        })
        mason_null_ls.setup({
            automatic_installation = true,
            ensure_installed = {
                "prettier",
                "clang-format",
                "php-cs-fixer",
                "shfmt",
                "shellharden",
            },
            handlers = {
                function(source, methods)
                    if methods == nil or vim.tbl_isempty(methods) then
                        return
                    end

                    for _, method in ipairs(methods) do
                        local configs = helpers.require_all("LSPConfig/" .. method)
                        local servers = vim.tbl_keys(configs)

                        if not vim.tbl_contains(servers, source) then
                            none_ls.register(none_ls.builtins[method][source])
                        else
                            none_ls.register(none_ls.builtins[method][source].with(configs[source]))
                        end
                    end
                end,
            },
        })
    end,
}
