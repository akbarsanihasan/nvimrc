return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 9999,
    opts = {
        flavour = "mocha",
        default_integrations = true,
        transparent_background = false,
        term_colors = true,
        background = {
            light = "latte",
            dark = "mocha",
        },
        styles = {
            booleans = { "bold" },
            functions = { "bold" },
            comments = { "italic" },
            types = { "italic" },
        },
    },
    init = function()
        vim.cmd.colorscheme("catppuccin")
    end,
}
