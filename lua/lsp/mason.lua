return {
	"williamboman/mason.nvim",
	init = function()
		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = true,
			signs = {
				text = {
					[vim.diagnostic.severity.HINT] = "󰛨",
					[vim.diagnostic.severity.INFO] = "󰌵",
					[vim.diagnostic.severity.WARN] = "󱧡",
					[vim.diagnostic.severity.ERROR] = "",
				},
				texthl = {
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				},
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
