return {
    'saghen/blink.cmp',
    dependencies = {
        'L3MON4D3/LuaSnip'
    },
    opts_extend = { "sources.default" },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        keymap = { preset = 'default' },
        fuzzy = { implementation = "lua" },
        signature = { enabled = false },
        cmdline = { enabled = false },
        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                org = { 'orgmode' }
            },
            providers = {
                orgmode = {
                    name = 'Orgmode',
                    module = 'orgmode.org.autocompletion.blink',
                    fallbacks = { 'buffer' },
                },
            },
        },
        completion = {
            documentation = { auto_show = true },
            list = { selection = { preselect = false, auto_insert = false } },
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind",  gap = 1 }
                    },
                }
            }
        },
    },
}
