return {
    {
        "tpope/vim-fugitive",
        keys = {
            {
                "<leader>ga",
                function()
                    if not vim.fs.root(0, ".git") then
                        vim.cmd.Git("init")
                    end

                    vim.cmd.Git()
                end,
                silent = true,
                noremap = true,
            },
            { "gf", ":diffget //2<CR>", silent = true, noremap = true },
            { "gj", ":diffget //3<CR>", silent = true, noremap = true },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {},
        keys = {
            {
                "<leader>gb",
                ":Gitsigns blame_line<CR>",
                silent = true,
                noremap = true,
            },
            {
                "<leader>gB",
                ":Gitsigns blame<CR>",
                silent = true,
                noremap = true,
            },
        },
    },
}
