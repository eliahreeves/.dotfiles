-- LSP configuration using nvim-lspconfig plugin
-- For standard/built-in servers that are in lspconfig's server list
return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("bashls")
            vim.lsp.enable("nixd")
            vim.lsp.enable("gopls")
            vim.lsp.enable("rust_analyzer")
        end,
    },
}
