return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        tabline = {},
    },
    -- opts = function(_, opts)
    --     opts.sections = {} -- disable bottom statusline
    --     opts.tabline = {
    --         lualine_a = { "tabs" },
    --     }
    --     opts.options = opts.options or {}
    --     opts.options.globalstatus = false
    --     vim.opt.laststatus = 0
    -- end,
    -- config = function()
    --     vim.o.laststatus = 0
    -- end,
}
-- dependencies = { "echasnovski/mini.icons" },
-- opts = function()
--     require("lualine").setup()
-- end,
-- }
