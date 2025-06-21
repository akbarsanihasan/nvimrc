vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.guicursor = ""

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.iskeyword:append("-")
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.autoread = true

vim.diagnostic.config({
    update_in_insert = false,
})
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

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})


local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local keymap_opts = {
            noremap = true,
            silent = true,
            buffer = event.buf,
        }

        local format_opts = {
            timeout_ms = 2000,
            async = false,
            buffer = event.buf,
        }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, keymap_opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, keymap_opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, keymap_opts)
        vim.keymap.set("n", "<leader>vdd", vim.diagnostic.open_float, keymap_opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, keymap_opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, keymap_opts)

        vim.keymap.set("n", "<leader>vfc", function()
            vim.lsp.buf.format(format_opts)
        end, keymap_opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("user_lsp_format", { clear = true }),
            callback = function()
                vim.lsp.buf.format(format_opts)
            end,
        })
    end,
})
