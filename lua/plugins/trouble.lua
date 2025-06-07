return {
    "folke/trouble.nvim",
    opts = {},
    keys = {
        {
            "<leader>tt",
            ":Trouble diagnostics toggle<cr>",
            silent = true,
        },
        {
            "]t",
            function()
                require("trouble").next({ skip_groups = true, jump = true })
            end,
            silent = true,
        },
        {
            "[t",
            function()
                require("trouble").prev({ skip_groups = true, jump = true })
            end,
            silent = true,
        },
    },
}
