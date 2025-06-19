return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
    config = function()
        local snippet_loader = require("luasnip.loaders.from_vscode")
        snippet_loader.lazy_load({ paths = { "./snippets" } })
    end,
}
