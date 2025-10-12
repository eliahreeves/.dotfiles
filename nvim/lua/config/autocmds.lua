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

-- Auto-detect and reload Pyright when entering Python projects with UV
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
    pattern = "*.py",
    callback = function()
        -- Check if we're in a UV project (has pyproject.toml or .venv)
        local cwd = vim.fn.getcwd()
        local has_pyproject = vim.fn.filereadable(cwd .. "/pyproject.toml") == 1
        local has_venv = vim.fn.isdirectory(cwd .. "/.venv") == 1
        
        if has_pyproject or has_venv then
            -- Restart Pyright to pick up the new environment
            vim.schedule(function()
                vim.cmd("LspRestart pyright")
            end)
        end
    end,
})