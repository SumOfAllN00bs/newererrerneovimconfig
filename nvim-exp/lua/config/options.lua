vim.keymap.set("c", "wq", "update | bdelete")
vim.g.have_nerd_font = true
vim.g.python3_host_prog = "/usr/sbin/python3"
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader><leader>", "gg=G", { desc = "Reindent whole file" })
vim.keymap.set("n", "<leader>ss", "<cmd>mksession! $VIMCONFIG/sessions/", { desc = "Save a session" })
vim.keymap.set("n", "<leader>sl", "<cmd>source $VIMCONFIG/sessions/", { desc = "Load a session" })
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.foldenable = false
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never",
        },
    },
}
if vim.g.started_by_firenvim then
    vim.opt.autowrite = true
    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            vim.cmd("w")
        end,
    })
    vim.api.nvim_create_autocmd("UIEnter", {
        callback = function()
            vim.fn.timer_start(1000, function()
                if vim.opt.lines:get() < 10 then
                    vim.opt.lines = 10
                end
                vim.cmd("startinsert")
            end)
        end,
    })
    vim.api.nvim_create_user_command("SubmitForm", function()
        vim.defer_fn(function()
            vim.cmd("w")
            vim.fn["firenvim#press_keys"]("<CR>")
            vim.fn["firenvim#hide_frame"]()
        end, 500)
    end, {})
    vim.api.nvim_set_keymap("n", "<C-CR>", ":SubmitForm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-CR>", "<Esc>:SubmitForm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
end
