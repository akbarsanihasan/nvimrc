return {
    "mason-org/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason-lspconfig.nvim",
        "nvimtools/none-ls.nvim",
        "nvimtools/none-ls-extras.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    init = function()
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = false,
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
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local none_ls = require("null-ls")
        local mason_null_ls = require("mason-null-ls")

        local code_format = function(bufnr)
            vim.lsp.buf.format({
                timeout_ms = 2000,
                async = false,
                bufnr = bufnr,
                filter = function(clt)
                    local active_clients = vim.tbl_map(function(client)
                        return client.name
                    end, vim.lsp.get_clients({ bufnr = bufnr }))

                    if vim.tbl_contains(active_clients, "null-ls") then
                        return clt.name == "null-ls"
                    end

                    return true
                end,
            })
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
            callback = function(event)
                local buffer = event.buf
                local opts = {
                    noremap = true,
                    silent = true,
                    buffer = buffer,
                }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, opts)
                vim.keymap.set("n", "<leader>vdd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vcf", function()
                    code_format(buffer)
                end, opts)

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("user_lsp_format", { clear = true }),
                    callback = function()
                        code_format(buffer)
                    end,
                })
            end,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        none_ls.setup({
            update_in_insert = false,
        })
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local lsp_server = {
            "gopls",
            "phpactor",
            "clangd",
            "rust_analyzer",
            "ts_ls",
            "lua_ls",
            "html",
            "cssls",
            "htmx",
        }
        mason_lspconfig.setup({
            automatic_enable = true,
            automatic_installation = true,
            ensure_installed = lsp_server,
        })

        local null_ls_server = {
            "prettier",
            "php-cs-fixer",
            "shfmt",
            "shellharden",
        }
        mason_null_ls.setup({
            automatic_installation = true,
            ensure_installed = null_ls_server,
            handlers = {},
        })
    end,
}
