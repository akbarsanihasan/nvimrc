return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
    config = function()
        local snippet_loader = require("luasnip.loaders.from_vscode")
        snippet_loader.lazy_load()
    end,
}
