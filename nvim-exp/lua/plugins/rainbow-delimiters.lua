return {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufNewFile" }, -- Optional: lazy-load on file open
    config = function()
        require("rainbow-delimiters.setup").setup({
            strategy = {
                [""] = "rainbow-delimiters.strategy.global", -- Default strategy for all filetypes
                vim = "rainbow-delimiters.strategy.local", -- Use local strategy for Vim files
            },
            query = {
                [""] = "rainbow-delimiters", -- Default query
                lua = "rainbow-blocks", -- Use rainbow-blocks for Lua
                python = "rainbow-blocks", -- Use rainbow-blocks for Lua
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        })
    end,
}
