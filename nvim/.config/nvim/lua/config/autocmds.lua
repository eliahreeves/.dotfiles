vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        if os.getenv("TMUX") then
            local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
            if bg then
                local hex = string.format("#%06x", bg)
                print("Background color:", hex)
                os.execute("tmux set-option status-style 'bg=" .. hex .. "' >/dev/null 2>&1")
            end
            -- Move tmux status to top when entering Neovim
            -- os.execute("tmux set-option status-position top >/dev/null 2>&1")

            -- And restore it when leaving
            vim.api.nvim_create_autocmd("VimLeave", {
                callback = function()
                    -- os.execute("tmux set-option status-position bottom >/dev/null 2>&1")
                    os.execute("tmux set-option status-style 'bg=default' >/dev/null 2>&1")
                end,
            })
        end
    end,
})
-- better c indent
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})
