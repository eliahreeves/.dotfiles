return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup_handlers({

                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({ capabilities = capabilities })
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function ()
                --     require("rust-tools").setup {}
                -- end
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            -- local lspconfig = require("lspconfig")
            -- lspconfig.ts_ls.setup({
            --     capabilities = capabilities,
            -- })
            -- lspconfig.html.setup({
            --     capabilities = capabilities,
            -- })
            -- lspconfig.lua_ls.setup({
            --     capabilities = capabilities,
            -- })
            -- lspconfig.clangd.setup({
            --     capabilities = capabilities,
            -- })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "go to references" })
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
