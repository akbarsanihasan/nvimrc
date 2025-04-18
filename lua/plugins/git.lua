return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
        keys = {
            {
                "<leader>gb",
                ":Git blame_line<CR>",
                silent = true,
                noremap = true,
            },
            {
                "<leader>gB",
                ":Git blame<CR>",
                silent = true,
                noremap = true,
            },
        },
    },
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>ga", ":Git<CR>",        silent = true, noremap = true },
            { "gf",         "diffget //2<CR>", silent = true, noremap = true },
            { "gj",         "diffget //3<CR>", silent = true, noremap = true },
        },
    },
}
