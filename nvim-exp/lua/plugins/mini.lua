return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.ai").setup({})
        require("mini.align").setup({})
        require("mini.basics").setup({})
        require("mini.bracketed").setup({})
        require("mini.diff").setup({})
        require("mini.extra").setup({})
        require("mini.git").setup({})
        require("mini.jump2d").setup({})
        require("mini.jump").setup({})
        require("mini.map").setup({})
        require("mini.misc").setup({})
        require("mini.move").setup({})
        require("mini.operators").setup({})
        require("mini.pairs").setup({})
        require("mini.pick").setup({})
        require("mini.sessions").setup({})
        require("mini.snippets").setup({})
        require("mini.splitjoin").setup({})
        require("mini.statusline").setup({})
        require("mini.surround").setup({})
        require("mini.tabline").setup({})
        require("mini.trailspace").setup({})
        require("mini.visits").setup({})
    end,
}
