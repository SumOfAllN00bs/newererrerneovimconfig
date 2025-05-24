require("config.lazy")

vim.cmd("colorscheme goodcolor")

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.f2",
  callback = function()
    vim.bo.filetype = "f2"
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.inc", -- You might want a more specific pattern if .inc is used elsewhere
  callback = function()
    vim.bo.filetype = "inc"
  end,
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.fasm2 = {
  install_info = {
    url = vim.fn.expand("~/Projects/tree_sitter_fasm2"),
    files = {"src/parser.c"},
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = { "f2", "inc" },
}
