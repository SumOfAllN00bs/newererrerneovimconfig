return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
        {
            "<leader>/",
            function() require('fzf-lua').lgrep_curbuf() end,
            desc = "Find in current buffer"
        },
        {
            "<leader>ff",
            function() require('fzf-lua').files() end,
            desc = "Find files in current working directory"
        },
        {
            "<leader>fh",
            function() require('fzf-lua').helptags() end,
            desc = "Find in vim help"
        },
        {
            "<leader>fk",
            function() require('fzf-lua').keymaps() end,
            desc = "Find in keymaps"
        },
        {
            "<leader>r",
            function() require('fzf-lua').live_grep() end,
            desc = "Find files by content"
        },
        {
            "<leader>nv",
            function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end,
            desc = "Find in neovim config"
        },
        {
            "<leader>b",
            function() require('fzf-lua').buffers() end,
            desc = "Find in buffers"
        },
        {
            "<leader>F",
            function() require('fzf-lua').builtin() end,
            desc = "Find in fzflua builtins"
        }
    }
}
