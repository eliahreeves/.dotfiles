if vim.env.NIX_NEOVIM then
    return {
        {
            "neovim/nvim-lspconfig",
            -- event = { "BufReadPre", "BufNewFile" },
            lazy = false,
            config = function()
                local lspconfig = require("lspconfig")
                local custom_servers = require("lspconfig.configs")
                local util = require("lspconfig.util")

                custom_servers.vtsls = {
                    default_config = {
                        cmd = { "vtsls", "--stdio" },
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                            "vue",
                        },
                        root_dir = function(fname)
                            return util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
                                or util.path.dirname(fname)
                        end,
                        settings = {},
                    },
                }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
                vim.diagnostic.config({
                    signs = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "●",
                    },
                    severity_sort = true,
                    float = {
                        border = "rounded",
                    },
                    underline = true,
                    update_in_insert = false,
                })

                vim.lsp.enable("lua_ls")
                vim.lsp.enable("bashls")
                vim.lsp.enable("nixd")
                vim.lsp.enable("gopls")
                vim.lsp.enable("pyright")
                vim.lsp.enable("vtsls")
            end,
        },
    }
else
    return {
        {
            "mason-org/mason.nvim",
            lazy = false,
            config = function()
                require("mason").setup()
            end,
        },
        {
            "mason-org/mason-lspconfig.nvim",
            lazy = false,
            -- event = { "BufReadPre", "BufNewFile" },
            dependencies = { "mason-org/mason.nvim" },
            config = function()
                require("mason-lspconfig").setup()
            end,
        },
        {
            "neovim/nvim-lspconfig",
            -- event = { "BufReadPre", "BufNewFile" },
            lazy = false,
            config = function()
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
                vim.diagnostic.config({
                    signs = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "●",
                    },
                    severity_sort = true,
                    float = {
                        border = "rounded",
                    },
                    underline = true,
                    update_in_insert = false,
                })
            end,
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            event = "VeryLazy",
            config = function()
                require("mason-tool-installer").setup({

                    -- a list of all tools you want to ensure are installed upon
                    -- start
                    ensure_installed = {

                        "bash-language-server",
                        -- "svlangserver",
                        "lua-language-server",
                        "stylua",
                        "shellcheck",
                        "shfmt",
                        "pyright",
                        "json-lsp",
                        "clangd",
                        "typescript-language-server",
                    },
                    auto_update = true,
                    run_on_start = true,
                    start_delay = 3000, -- 3 second delay
                })
            end,
        },
    }
end
