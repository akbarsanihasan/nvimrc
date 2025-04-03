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
		init = function()
			local opts = { silent = true, noremap = true }

			vim.keymap.set("n", "<leader>ga", ":Git<CR>", opts)
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", opts)
			vim.keymap.set("n", "gf", "diffget //2<CR>", opts)
			vim.keymap.set("n", "gj", "diffget //3<CR>", opts)
		end,
	},
}
