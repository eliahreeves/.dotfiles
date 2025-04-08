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

-- vim.api.nvim_create_autocmd("UIEnter", {
--     callback = function()
--         vim.opt.laststatus = 0
--     end,
-- })
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         os.execute("tmux set-option status-position top")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("VimLeave", {
--     callback = function()
--         os.execute("tmux set-option status-position bottom")
--     end,
-- })
