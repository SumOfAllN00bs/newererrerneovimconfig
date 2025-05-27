return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "python",
                "bash",
                "yaml",
                "json",
            },
            auto_install = true,
            sync_install = false,
            ignore_install = { "" },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            modules = {},
            textobjects = {
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@statement.outer",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@statement.outer",
                    },
                },
                select = {
                    enable = true,

                    lookahead = true,

                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    scope_incremental = false,
                    node_decremental = "<Backspace>",
                },
            },
        })
    end,
}
