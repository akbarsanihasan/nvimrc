return {
	"neovim/nvim-lspconfig",
	event = "BufEnter",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"nvimtools/none-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
		"pmizio/typescript-tools.nvim",
	},
	init = function()
		vim.fn.sign_define("DiagnosticSignError", {
			text = "",
			texthl = "DiagnosticSignError",
		})
		vim.fn.sign_define("DiagnosticSignWarn", {
			text = "󱧡",
			texthl = "DiagnosticSignWarn",
		})
		vim.fn.sign_define("DiagnosticSignInfo", {
			text = "󰌵",
			texthl = "DiagnosticSignInfo",
		})
		vim.fn.sign_define("DiagnosticSignHint", {
			text = "󰛨",
			texthl = "DiagnosticSignHint",
		})
	end,
	config = function()
		local EXCLUDE_SERVER = { "tsserver", "ts_ls" }
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local typescript_tools = require("typescript-tools")

		local table_includes = function(table, value)
			for _, v in pairs(table) do
				if v == value then
					return true
				end
			end
			return false
		end

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities()
		)

		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<leader>vdd", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		mason_lspconfig.setup({
			handlers = {
				function(server_name)
					if not table_includes(EXCLUDE_SERVER, server_name) then
						lspconfig[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
							single_file_support = true,
						})
					end
				end,
				emmet_ls = function()
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						filetypes = {
							"astro",
							"css",
							"eruby",
							"html",
							"htmldjango",
							"javascriptreact",
							"less",
							"pug",
							"sass",
							"scss",
							"svelte",
							"typescriptreact",
							"vue",
							"htmlangular",
							"htmlangular",
							"php",
							"blade",
						},
					})
				end,
				lua_ls = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							},
						},
					})
				end,
			},
		})

		typescript_tools.setup({
			capabilities = capabilities,
			single_file_support = true,
			on_attach = function()
				on_attach()
				vim.keymap.set("n", "<leader>tsoi", ":TSToolsOrganizeImport<CR>", { noremap = true, silent = true })
				vim.keymap.set("n", "<leader>tsru", ":TSToolsRemoveUnused<CR>", { noremap = true, silent = true })
				vim.keymap.set("n", "<leader>tsmi", ":TSToolsAddMissingImports<CR>", { noremap = true, silent = true })
				vim.keymap.set("n", "<leader>tsfa", ":TSToolsFixAll<CR>", { noremap = true, silent = true })
				vim.keymap.set("n", "<leader>tsrf", ":TSToolsRenameFile<CR>", { noremap = true, silent = true })
			end,
		})

		vim.diagnostic.config({
			update_in_insert = true,
		})
	end,
}
