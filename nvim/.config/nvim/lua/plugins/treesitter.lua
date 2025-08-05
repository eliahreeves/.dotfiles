if vim.env.NIX_NEOVIM then
    require("nvim-treesitter.configs").setup({
        ensure_installed = {},
        auto_install = false,
    })
    return {}
else
    return {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = { "VeryLazy" },
            lazy = vim.fn.argc(-1) == 0,
            opts = {
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                keys = {
                    { "<C-space>", desc = "Increment Selection" },
                    { "<bs>", desc = "Decrement Selection", mode = "x" },
                },
            },
        },
    }
end
