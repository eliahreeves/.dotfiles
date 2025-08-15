return {
    "echasnovski/mini.files",
    version = "*",
    opts = { options = { use_as_default_explorer = false } },
    keys = {
        {
            "<leader>e",
            function()
                require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
            end,
            desc = "Open mini.files (Directory of Current File)",
        },
        {
            "<leader>E",
            function()
                require("mini.files").open(vim.uv.cwd(), true)
            end,
            desc = "Open mini.files (cwd)",
        },
    },
    config = function()
        require("mini.icons").setup()
    end,
}
