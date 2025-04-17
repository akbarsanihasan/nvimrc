return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>ga", ":Git<CR>", silent = true, noremap = true },
			{ "<leader>gb", ":Git blame<CR>", silent = true, noremap = true },
			{ "gf", "diffget //2<CR>", silent = true, noremap = true },
			{ "gj", "diffget //3<CR>", silent = true, noremap = true },
		},
	},
}
