return {
	require_cwd = false,
	args = function(_, ctx)
		local prettier_roots = {
			".editroconfig",
			".prettierrc",
			".prettierrc.json",
			".prettierrc.yaml",
			".prettierrc.toml",
			".prettierrc.js",
			".prettierrc.mjs",
			".prettierrc.cjs",
			"prettier.config.js",
			"prettier.config.mjs",
			"prettier.config.cjs",
		}

		local args = {
			"--tab-width",
			"4",
			"--no-semi",
			"--no-bracket-spacing",
			"--single-quote",
			"--stdin-filepath",
			"$FILENAME",
		}

		local disableGlobalPrettierConfig = os.getenv("DISABLE_GLOBAL_PRETTIER_CONFIG")

		local localPrettierConfig = vim.fs.find(prettier_roots, {
			upward = true,
			type = "file",
		})[1]

		local globalPrettierConfig = vim.fs.find(prettier_roots, {
			---@diagnostic disable-next-line: assign-type-mismatch
			path = vim.fn.stdpath("config"),
			type = "file",
		})[1]

		local hasTailwindPrettierPlugin = vim.fs.find("node_modules/prettier-plugin-tailwindcss", {
			upward = true,
			path = ctx.dirname,
			type = "directory",
		})[1]

		if hasTailwindPrettierPlugin then
			vim.list_extend(args, { "--plugin", "prettier-plugin-tailwindcss" })
		end

		if localPrettierConfig then
			args = { "--config", localPrettierConfig, "--stdin-filepath", "$FILENAME" }
		elseif globalPrettierConfig and not disableGlobalPrettierConfig then
			args = { "--config", globalPrettierConfig, "--stdin-filepath", "$FILENAME" }
		end

		return args
	end,
}
