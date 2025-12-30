return {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {},
    keys = {
        {
            "<leader>uf",
            function()
                vim.cmd("FlutterReload")
            end,
            desc = "Flutter Restart (rebuild)",
        },
    },
}
