return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "Kaiser-Yang/blink-cmp-git" },

    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "default",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Enter>"] = { "select_and_accept", "fallback" },
            ["<F1>"] = { "show_documentation", "fallback" },
            ["<C-n>"] = { "scroll_documentation_down", "fallback" },
            ["<C-p>"] = { "scroll_documentation_up", "fallback" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = { documentation = { auto_show = false } },
        signature = {
            enabled = true,
            window = { border = "rounded" },
        },

        sources = {
            default = { "git", "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                sql = { "snippets", "dadbod", "buffer" },
            },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                git = {
                    module = "blink-cmp-git",
                    enabled = function()
                        return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
                    end,
                    name = "Git",
                    opts = {},
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
