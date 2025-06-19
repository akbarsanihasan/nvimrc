return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "auto",
            icons_enabled = true,
            always_divide_middle = true,
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            extensions = {
                "lazy",
            },
            ignore_focus = {
                "TelescopePrompt",
                "neo-tree",
            },
            disabled_filetypes = {
                statusline = {
                    "neo-tree",
                    "neo-tree-popup",
                    "TelescopePrompt",
                    "lazy",
                    "undotree",
                    "fugitive",
                    "mason",
                    "diff",
                    "noice",
                },
                winbar = {
                    "neo-tree",
                    "neo-tree-popup",
                    "TelescopePrompt",
                    "lazy",
                    "undotree",
                    "fugitive",
                    "mason",
                    "diff",
                    "noice",
                },
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                {
                    "diagnostics",
                    symbols = {
                        error = " ",
                        warn = "󱧡 ",
                        hint = "󰛨 ",
                        info = "󰌵 ",
                    },
                },
            },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
    },
}
