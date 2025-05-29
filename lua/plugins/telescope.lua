return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = function()
        local builtin = require("telescope.builtin")

        pickers = {
            find_files = {
                follow = true,
            },
            live_grep = {
                hidden = true,
            }
        }
        return {
            {
                "<C-p>",
                function()
                    builtin.find_files({ follow = true })
                end,
                silent = true,
                noremap = true
            },
            {
                "<leader>oh",
                function()
                    builtin.find_files({
                        hidden = true,
                        find_command = {
                            "rg",
                            "--files",
                            "--glob",
                            "!**/.git/*",
                            "--glob",
                            "!**/vendor/*",
                            "--glob",
                            "!**node_modules/*",
                        },
                    })
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>os",
                function()
                    builtin.live_grep({ hidden = true })
                end,
                silent = true,
                noremap = true
            },
            {
                "<leader>og",
                function()
                    builtin.git_files({ hidden = true })
                end,
                silent = true,
                noremap = true
            },
        }
    end,
    opts = {
        defaults = {
            prompt_prefix = " 󰭎  ",
            selection_caret = " ",
            path_display = { "absolute" },
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                height = 0.6,
                width = 0.4,
                anchor = "N",
                prompt_position = "top",
            },
            mappings = {
                n = {
                    ["<C-t>"] = "nop",
                },
                i = {
                    ["<C-t>"] = "nop",
                },
            },
        },
    },
}
