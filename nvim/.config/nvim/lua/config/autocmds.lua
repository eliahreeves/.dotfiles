----- start zellij -----
-- https://github.com/fresh2dev/zellij-autolock/issues/11#issuecomment-2575922784
-- local function zellij(mode)
--     vim.schedule(function()
--         if vim.env.ZELLIJ ~= nil then
--             vim.fn.system({ "zellij", "action", "switch-mode", mode })
--         end
--     end)
-- end
--
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
--     callback = function()
--         zellij("locked")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave" }, {
--     callback = function()
--         zellij("normal")
--     end,
-- })

----- end zellij -----

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
