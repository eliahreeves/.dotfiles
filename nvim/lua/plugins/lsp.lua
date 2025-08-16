if vim.env.NIX_NEOVIM then
    return {
        {
            "neovim/nvim-lspconfig",
            -- event = { "BufReadPre", "BufNewFile" },
            lazy = false,
            config = function()
                local lspconfig = require("lspconfig")
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

                lspconfig.lua_ls.setup({})
                lspconfig.bashls.setup({})
                lspconfig.nixd.setup({})
                lspconfig.gopls.setup({})
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
