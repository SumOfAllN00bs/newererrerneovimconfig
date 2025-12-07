require("config.lazy")

vim.cmd("colorscheme goodcolor")
vim.cmd("cnoreabbrev messages Bmessages")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.f2",
    callback = function()
        vim.bo.filetype = "f2"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.inc",
    callback = function()
        vim.bo.filetype = "inc"
    end,
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
---@diagnostic disable-next-line: inject-field
parser_config.fasm2 = {
    install_info = {
        url = vim.fn.expand("/mnt/Dump/Projects/tree_sitter_fasm2"),
        files = { "src/parser.c" },
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    },
    filetype = { "f2", "inc" },
}
