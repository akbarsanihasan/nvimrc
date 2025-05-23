local M = {}

M.exclude_servers = {}

M.capabilities = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    return vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
    )
end

M.lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        timeout_ms = 2000,
        async = false,
        bufnr = bufnr,
        filter = function(client)
            local active_lsp = vim.tbl_map(function(clt)
                return clt.name
            end, vim.lsp.get_clients({ bufnr = bufnr }))

            if vim.tbl_contains(active_lsp, "null-ls") then
                return client.name == "null-ls"
            end

            return true
        end,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
M.on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>vdd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, opts)
    vim.keymap.set("n", "<leader>vrs", ":LspRestart<CR>", opts)
    vim.keymap.set("n", "<leader>fr", function()
        M.lsp_formatting()
    end)

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                M.lsp_formatting(bufnr)
            end,
        })
    end
end

return M
