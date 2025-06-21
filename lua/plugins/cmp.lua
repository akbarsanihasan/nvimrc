return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
        local cmp = require("cmp")
        return {
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            }),
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            formatting = {
                fields = { "abbr", "kind" },
                format = function(_, vim_item)
                    vim_item.symbol = vim_item.kind
                    return vim_item
                end,
            },
            mapping = {
                ["<C-y>"] = cmp.mapping.confirm({ select = false }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
            },
        }
    end,
}
