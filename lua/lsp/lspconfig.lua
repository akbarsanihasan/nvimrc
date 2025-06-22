return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_capabilities = require('blink.cmp').get_lsp_capabilities({}, false)
        local ext_capabilities = {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true
                }
            }
        }


        vim.lsp.config("*", {
            single_file_support = true,
            capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_capabilities,
                ext_capabilities
            ),
        })

        mason_lspconfig.setup({
            automatic_enable = true,
        })
    end,
}
