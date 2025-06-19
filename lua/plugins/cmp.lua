return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip"
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        return {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
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
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            }),
        }
    end,
}
