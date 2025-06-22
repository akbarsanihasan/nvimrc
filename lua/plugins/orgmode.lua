return {
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        dependencies = {
            "nvim-orgmode/org-bullets.nvim",
            "danilshvalov/org-modern.nvim",
        },
        config = function()
            local orgmode = require("orgmode")
            local orgmode_menu = require("org-modern.menu")

            orgmode.setup({
                org_agenda_files = '~/Notes/**/*',
                org_default_notes_file = '~/Notes/refile.org',
                ui = {
                    menu = {
                        handler = function(data)
                            orgmode_menu:new({
                                window = {
                                    margin = { 1, 0, 1, 0 },
                                    padding = { 0, 1, 0, 1 },
                                    title_pos = "center",
                                    border = "single",
                                    zindex = 1000,
                                },
                                icons = {
                                    separator = "➜",
                                },
                            }):open(data)
                        end,
                    },
                },
            })
        end
    },
    {
        "nvim-orgmode/org-bullets.nvim",
        config = true,
    },
    {
        "nvim-orgmode/telescope-orgmode.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-orgmode/orgmode",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("orgmode")
            vim.keymap.set("n", "<leader>orh", require("telescope").extensions.orgmode.refile_heading)
            vim.keymap.set("n", "<leader>osh", require("telescope").extensions.orgmode.search_headings)
            vim.keymap.set("n", "<leader>oil", require("telescope").extensions.orgmode.insert_link)
        end,
    }
}
