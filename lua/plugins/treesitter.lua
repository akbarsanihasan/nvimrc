return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
        ignore_install = { 'org' },
        indent = {
            enable = true
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
    init = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.blade = {
            filetype = "blade",
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
        }
    end,
}
