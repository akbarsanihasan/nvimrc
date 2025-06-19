return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
        local harpoon = require("harpoon")
        return {
            {
                "<M-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                silent = true,
            },
            {
                "<M-s>",
                function()
                    harpoon:list():add()
                end,
                silent = true,
            },
            {
                "<M-o>",
                function()
                    harpoon:list():prev()
                end,
                silent = true,
            },
            {
                "<M-p>",
                function()
                    harpoon:list():next()
                end,
                silent = true,
            },
            {
                "<M-j>",
                function()
                    harpoon:list():select(1)
                end,
                silent = true,
            },
            {
                "<M-k>",
                function()
                    harpoon:list():select(2)
                end,
                silent = true,
            },
            {
                "<M-h>",
                function()
                    harpoon:list():select(3)
                end,
                silent = true,
            },
            {
                "<M-l>",
                function()
                    harpoon:list():select(4)
                end,
                silent = true,
            },
        }
    end,
}
