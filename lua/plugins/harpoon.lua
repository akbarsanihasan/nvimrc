return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		local harpoon = require("harpoon")
		local keys = {
			{
				"<M-e>",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
			},
			{
				"<M-s>",
				function()
					harpoon:list():add()
				end,
			},
			{
				"<M-o>",
				function()
					harpoon:list():prev()
				end,
			},
			{
				"<M-p>",
				function()
					harpoon:list():next()
				end,
			},
			{
				"<M-j>",
				function()
					harpoon:list():select(1)
				end,
			},
			{
				"<M-k>",
				function()
					harpoon:list():select(2)
				end,
			},
			{
				"<M-h>",
				function()
					harpoon:list():select(3)
				end,
			},
			{
				"<M-l>",
				function()
					harpoon:list():select(4)
				end,
			},
		}
		return keys
	end,
}
