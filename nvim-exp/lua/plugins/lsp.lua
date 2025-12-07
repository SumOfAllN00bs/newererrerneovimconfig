return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        "saghen/blink.cmp",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
                map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
                map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
                map("grd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
                map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                map("gO", require("fzf-lua").lsp_document_symbols, "Open Document Symbols")
                map("gW", require("fzf-lua").lsp_live_workspace_symbols, "Open Workspace Symbols")
                map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")

                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = vim.g.have_nerd_font and {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            } or {},
            virtual_text = {
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

        local mason_servers = {
            bashls = {},
            rust_analyzer = {},
            pyright = {},
        }

        local ensure_installed = vim.tbl_keys(mason_servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
            "prettierd",
            "prettier",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
            automatic_enable = true,
            handlers = {
                function(server_name)
                    local server = mason_servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
        local runtime_paths = vim.api.nvim_get_runtime_file("", true)
        table.insert(runtime_paths, vim.fn.stdpath("data") .. "/lazy")
        table.insert(runtime_paths, "${3rd}/luv/library")
        vim.lsp.config("lua_ls", {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = runtime_paths,
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        vim.lsp.config("rust_analyzer", {
            settings = {
                checkOnSave = {
                    allTargets = false,
                },
                cargo = {
                    noDefaultFeatures = true,
                },
            },
        })
        vim.lsp.config("fasmlsp", {
            cmd = { "node", "/mnt/Dump/Projects/fasmlsp/dist/server.js" },
            filetypes = { "f2", "fasm", "asm", "inc" },
            root_markers = { ".git" },
            capabilities = capabilities,
            settings = {},
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("fasmlsp")
    end,
}
