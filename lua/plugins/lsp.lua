return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "folke/trouble.nvim",
        },
        init = function()
            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.HINT] = "󰛨",
                        [vim.diagnostic.severity.INFO] = "󰌵",
                        [vim.diagnostic.severity.WARN] = "󱧡",
                        [vim.diagnostic.severity.ERROR] = "",
                    },
                    texthl = {
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    },
                },
            })
        end,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local lsp_utils = require("Utils.lsp")
            local helpers = require("Utils.helpers")
            local providers = helpers.require_all("LSP/providers")
            local provider_names = vim.tbl_keys(providers)

            mason_lspconfig.setup({
                automatic_installation = true,
                ensure_installed = {
                    "gopls",
                    "phpactor",
                    "clangd",
                    "rust_analyzer",
                    "ts_ls",
                    "lua_ls",
                    "html",
                    "cssls",
                    "htmx",
                },
                handlers = {
                    function(provider_name)
                        local server_config = {}
                        local default_server_config = {
                            require_cwd = false,
                            single_file_support = true,
                            capabilities = lsp_utils.capabilities(),
                            on_attach = lsp_utils.on_attach,
                        }

                        if vim.tbl_contains(provider_names, provider_name) then
                            server_config = vim.tbl_deep_extend(
                                "force",
                                server_config,
                                default_server_config,
                                helpers.return_call(providers[provider_name], "table")
                            )
                        else
                            server_config = default_server_config
                        end

                        lspconfig[provider_name].setup(server_config)
                    end,
                },
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            local none_ls = require("null-ls")
            local mason_null_ls = require("mason-null-ls")
            local helpers = require("Utils.helpers")
            local sources = helpers.require_all("LSP/sources")
            local source_names = vim.tbl_keys(sources)
            local lsp_utils = require("Utils.lsp")

            none_ls.setup({
                on_attach = lsp_utils.on_attach,
            })
            mason_null_ls.setup({
                automatic_installation = true,
                ensure_installed = {
                    "prettier",
                    "php-cs-fixer",
                    "shfmt",
                    "shellharden",
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
    },
}
