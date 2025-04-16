return {
	"williamboman/mason.nvim",
	init = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = true,
			hint = {
				text = "󰛨",
				texthl = "DiagnosticSignHint",
			},
			info = {
				text = "󰌵",
				texthl = "DiagnosticSignInfo",
			},
			warn = {
				text = "󱧡",
				texthl = "DiagnosticSignWarn",
			},
			error = {
				text = "",
				texthl = "DiagnosticSignError",
			},
		})
	end,
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
