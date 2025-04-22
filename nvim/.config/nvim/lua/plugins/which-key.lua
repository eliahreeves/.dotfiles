return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>c", group = "code" },
                { "gs", group = "surround" },
                { "g", group = "goto" },
                { "<leader>b", group = "buffers" },
                { "<leader>g", group = "git" },
                { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                { "<leader>q", group = "persistance", icon = { icon = " ", color = "yellow" } },
                { "<leader>P", group = "paste image", icon = { icon = " ", color = "blue" } },
            },
        },
    },
    keys = {},
}
