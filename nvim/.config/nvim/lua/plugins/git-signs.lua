return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>gb",
            "<cmd>Gitsigns toggle_current_line_blame<cr>",
            desc = "Toggle blame in virtual text",
        },
        {
            "Y",
            "<cmd>Gitsigns blame_line<cr>",
            desc = "Show current line blame",
        },
    },
}
