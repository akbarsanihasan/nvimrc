return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
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
		},

		{
			"[t",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
		},
	},
}
