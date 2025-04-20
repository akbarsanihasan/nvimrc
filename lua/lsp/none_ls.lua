return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    opts = function()
        local lsp_utils = require("Utils.lsp")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        return {
            on_attach = function(client, bufnr)
                lsp_utils.on_attach(client, bufnr)

                if client:supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                timeout_ms = 2000,
                                async = false,
                            })
                        end,
                    })
                end
            end,
        }
    end,
    config = function(_, opts)
        local none_ls = require("null-ls")
        local mason_null_ls = require("mason-null-ls")
        local helpers = require("Utils.helpers")
        local sources = helpers.require_all("lsp/sources")
        local source_names = vim.tbl_keys(sources)

        none_ls.setup(opts)
        mason_null_ls.setup({
            automatic_installation = true,
            ensure_installed = {
                "prettier",
                "php-cs-fixer",
                "stylua",
                "shellharden",
                "shfmt",
            },
            handlers = {
                function(source, methods)
                    if next(methods) == nil then
                        return
                    end

                    for _, method in ipairs(methods) do
                        if vim.tbl_contains(source_names, source) then
                            none_ls.register(none_ls.builtins[method][source].with(sources[source][method]))
                        else
                            none_ls.register(none_ls.builtins[method][source])
                        end
                    end
                end,
            },
        })
    end,
}
