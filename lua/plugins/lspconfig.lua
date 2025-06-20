return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local helpers = require("Utils.helpers")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local servers = helpers.require_all("serverconfig")

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
            },
        })
    end,
}
