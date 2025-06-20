return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
        auto_install = true,
        ensure_installed = {
            "go",
            "php",
            "javascript",
            "typescript",
            "c",
            "rust",
            "lua",
            "blade",
            "html",
            "css",
            "markdown",
            "json",
            "jsonc",
            "yaml",
            "xml",
        },
        ignore_install = { 'org' },
        indent = { enable = true },
        with_sync = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
        },
    },
    config = function(_, opts)
        local treesitter = require("nvim-treesitter.configs")
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        vim.filetype.add({
            pattern = {
                [".*%.blade%.php"] = "blade",
                [".*/hypr/.*%.conf"] = "hyprlang",
            },
        })

        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }

        treesitter.setup(opts)
    end,
}
