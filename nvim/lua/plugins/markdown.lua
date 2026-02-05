return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_close = 1

        -- Custom function to open Firefox
        vim.cmd([[
            function! OpenMarkdownPreview(url)
                execute "silent !firefox " . a:url . " &"
            endfunction
        ]])

        vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
    ft = { "markdown" },
}
