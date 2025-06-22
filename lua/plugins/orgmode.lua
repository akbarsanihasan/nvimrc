return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    dependencies = {
        "nvim-orgmode/org-bullets.nvim",
        "nvim-orgmode/telescope-orgmode.nvim",
    },
    config = function()
        local orgmode = require("orgmode")
        local orgbullets = require("org-bullets")
        local telescope = require("telescope")

        orgbullets.setup()
        orgmode.setup({
            org_agenda_files = '~/Personal/Orgnotes/**/*',
            org_default_notes_file = '~/Personal/Orgnotes/Refile.org',
            org_capture_templates = {
                j = {
                    description = 'Journal',
                    template = '* %<%Y-%m-%d> %<%A>\n%?',
                    target = '~/sync/org/journal/%<%Y-%m>.org'
                },
            }
        })

        telescope.load_extension("orgmode")
        vim.keymap.set("n", "<leader>orh", telescope.extensions.orgmode.refile_heading)
        vim.keymap.set("n", "<leader>osh", telescope.extensions.orgmode.search_headings)
        vim.keymap.set("n", "<leader>oil", telescope.extensions.orgmode.insert_link)
    end
}
