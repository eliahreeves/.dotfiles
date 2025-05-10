return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
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
        end,
    },
}
