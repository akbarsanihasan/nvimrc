return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            auto_install = true,
            sync_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
                "go",
                "php",
                "javascript",
                "typescript",
                "c",
                "rust",
                "lua",
                "bash",
                "html",
                "css",
            }
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
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            enable = true,
            multiwindow = false,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
            separator = nil,
            zindex = 20,
        }
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false
            },
        }
    }
}
