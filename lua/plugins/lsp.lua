return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer",
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            require('mason-tool-installer').setup {
                auto_update = true,
                run_on_start = true,
                start_delay = 3000,
                integrations = {
                    ['mason-lspconfig'] = true,
                    ['mason-null-ls'] = true,
                },
                ensure_installed = {
                    "gopls",
                    "phpactor",
                    "clangd",
                    "rust_analyzer",
                    "ts_ls",
                    "lua_ls",
                    "html",
                    "cssls",
                    "prettier",
                    "clang-format",
                    "beautysh",
                    "bash-language-server",
                    "shellharden",
                    "emmet_ls",
                },
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local lib = require("lib.helpers")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local servers = lib.require_all("custom_lsp")

            vim.lsp.config("*", {
                single_file_support = true,
                capabilities = vim.tbl_deep_extend(
                    "force",
                    {},
                    vim.lsp.protocol.make_client_capabilities(),
                    cmp_nvim_lsp.default_capabilities()
                ),
            })

            for server_name, config in pairs(servers) do
                vim.lsp.config(server_name, config)
            end

            mason_lspconfig.setup({
                automatic_enable = true,
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "mason-org/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            local lib = require("lib.helpers")
            local none_ls = require("null-ls")
            local mason_null_ls = require("mason-null-ls")

            mason_null_ls.setup({
                handlers = {
                    function(source, methods)
                        if methods == nil or vim.tbl_isempty(methods) then
                            return
                        end

                        for _, method in ipairs(methods) do
                            local configs = lib.require_all("custom_lsp/" .. method)
                            local null_servers = vim.tbl_keys(configs)

                            if not vim.tbl_contains(null_servers, source) then
                                none_ls.register(none_ls.builtins[method][source])
                            else
                                none_ls.register(none_ls.builtins[method][source].with(configs[source]))
                            end
                        end
                    end,
                },
            })
        end
    }
}
