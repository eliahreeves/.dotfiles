return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.g.vimtex_quickfix_mode = 0
    end,
    keys = {
        {
            "<leader>ul",
            function()
                vim.cmd("VimtexCompile")
            end,
            desc = "Compile LaTeX",
        },
    },
}
